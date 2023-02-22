//
//  AVPlayer.swift
//  Mi-sha
//
//  Created by MM on 13.02.2023.
//

import SwiftUI
import Combine
import AVKit

class MediaPlayer {
    var player: AVPlayer
    var currentTimePublisher: PassthroughSubject<Double, Never> = .init()
    var currentProgressPublisher: PassthroughSubject<Float, Never> = .init()
    private var playerPeriodicObserver: Any?
    
    init(url: URL) {
        player = AVPlayer(url: url) // Инитим с помощью URL
        setupPeriodicObservation(for: player) // Обсервера устанавливаем в плеер
    }
    
    private func setupPeriodicObservation(for player: AVPlayer) {
        let timeScale = CMTimeScale(NSEC_PER_SEC)
        let time = CMTime(seconds: 0.5, preferredTimescale: timeScale)
        
        playerPeriodicObserver = player.addPeriodicTimeObserver(forInterval: time, queue: .main) { [weak self] (time) in
            guard let `self` = self else { return }
            let progress = self.calculateProgress(currentTime: time.seconds)
            self.currentProgressPublisher.send(progress)
            self.currentTimePublisher.send(time.seconds)
        }
    }
    
    private func calculateProgress(currentTime: Double) -> Float {  // Прогресс
        return Float(currentTime / duration)
    }
    
    private var duration: Double {
        return player.currentItem?.duration.seconds ?? 0
    }
    
    func play() {
        player.play()
    }
    
    func pause() {
        player.pause()
    }
    
    func seek(to time: CMTime) {
        player.seek(to: time)
    }
    
    func seek(to percentage: Float) {
        let time = convertFloatToCMTime(percentage)
        player.seek(to: time)
    }
    
    private func convertFloatToCMTime(_ percentage: Float) -> CMTime {
        return CMTime(seconds: duration * Double(percentage), preferredTimescale: CMTimeScale(NSEC_PER_SEC))
    }
}

