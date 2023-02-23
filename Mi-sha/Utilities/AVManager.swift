//
//  AudioManager.swift
//  Mi-sha
//
//  Created by MM on 12.12.2022.
//

import SwiftUI
import AVKit
import Combine

class AVManager: ObservableObject {
    
    @Published var streamPlayer = AVPlayer()
    @Published var isPlaying: Bool = false
    @Published var isLoop = false
    @Published var isDownloaded = false
    @Published var sliderProgress: Float = 0
    var somethingBad = false
    static var shared = AVManager()
    var dataManager = DataManager.shared
    
    //init 4 combine
    var currentTimePublisher: PassthroughSubject<Double, Never> = .init()
    var currentProgressPublisher: PassthroughSubject<Float, Never> = .init()
    private var playerPeriodicObserver: Any?
    
    private init() {
        setupPeriodicObservation(for: streamPlayer)
    }
    
    
    //MARK StreamPlayer func
    var playerItem: AVPlayerItem?
    var isPlayerInit: Bool = false

   func initPlayer(url: String) {
       guard let url = URL.init(string: url) else { return }
       self.playerItem = AVPlayerItem(url: url)
       streamPlayer = AVPlayer.init(playerItem: playerItem)
       try! AVAudioSession.sharedInstance().setCategory(.playback)
       streamPlayer.play()
       isPlayerInit = true
       self.isPlaying = true
       }

    func streamPlayPause() {
        if self.isPlaying {
            streamPlayer.pause()
            isPlaying.toggle()
        } else {
            streamPlayer.play()
            isPlaying.toggle()
        }
    }
    
    func streamPlayerStop() {
        if self.isPlaying {
            streamPlayer.pause()
            isPlaying = false
        }
    }
    
    private func setupPeriodicObservation(for player: AVPlayer) {
        let timeScale = CMTimeScale(NSEC_PER_SEC)
        let time = CMTime(seconds: 0.5, preferredTimescale: timeScale)
        
        playerPeriodicObserver = streamPlayer.addPeriodicTimeObserver(forInterval: time, queue: .main) { [weak self] (time) in
            guard let `self` = self else { return }
            let progress = self.calculateProgress(currentTime: time.seconds)
            self.currentProgressPublisher.send(progress)
            self.currentTimePublisher.send(time.seconds)
        }
    }
    
    
    // проверяем наличие
    // создаём кюррент тайм
    // создаём новое время
    func streamPlayerForward() {
        guard let duration  = streamPlayer.currentItem?.duration else {
            return
        }
        let playerCurrentTime = CMTimeGetSeconds(streamPlayer.currentTime())
        let newTime = playerCurrentTime + 10

        if newTime < (CMTimeGetSeconds(duration) - 10) {

            let time2: CMTime = CMTimeMake(value: Int64(newTime * 1000 as Float64), timescale: 1000)
            streamPlayer.seek(to: time2, toleranceBefore: CMTime.zero, toleranceAfter: CMTime.zero)
        }
    }

    func streamPlayerBackward() {
        let playerCurrentTime = CMTimeGetSeconds(streamPlayer.currentTime())
            var newTime = playerCurrentTime - 10

            if newTime < 0 {
                newTime = 0
            }
        let time2: CMTime = CMTimeMake(value: Int64(newTime * 1000 as Float64), timescale: 1000)
        streamPlayer.seek(to: time2, toleranceBefore: CMTime.zero, toleranceAfter: CMTime.zero)
    }
    
    func getStreamPlayerTime() -> Double? {
        let currentTime = CMTimeGetSeconds(playerItem?.currentTime() ?? CMTime.zero)
        return currentTime
//        return 30
    }
    
    func getStreamPlayerDuration() -> Double? {
        if streamPlayer.currentItem?.status == AVPlayerItem.Status.readyToPlay {
            guard let durationCMTime = streamPlayer.currentItem?.duration
                    //        CMTimeGetSeconds(playerItem?.duration ?? CMTime.zero)
            else { return 0 }
            let duration = CMTimeGetSeconds(durationCMTime)
//            print("Duration: \(duration)")
            return duration
        }
        else { return 0 }
    }
    
    
    private func calculateProgress(currentTime: Double) -> Float {  // Прогресс
        return Float(currentTime / duration)
    }
    
    private var duration: Double {
        return streamPlayer.currentItem?.duration.seconds ?? 0
    }
    
    func play() {
        streamPlayer.play()
    }
    
    func pause() {
        streamPlayer.pause()
    }
    
    func seek(to time: CMTime) {
        streamPlayer.seek(to: time)
    }
    
    func seek(to percentage: Float) {
        let time = convertFloatToCMTime(percentage)
        streamPlayer.seek(to: time)
    }
    
    private func convertFloatToCMTime(_ percentage: Float) -> CMTime {
        return CMTime(seconds: duration * Double(percentage), preferredTimescale: CMTimeScale(NSEC_PER_SEC))
    }
    
//    var observation = playerItem?.observe(\AVPlayerItem.status, changeHandler: { observedPlayerItem, change in
//        if (observedPlayerItem.status == AVPlayerItem.Status.readyToPlay) {
//            print("Current stream duration \(observedPlayerItem.duration.seconds)")
//        }
//    })
    
//    func getDuration() -> String {
//
//        var duration = audioManager.player?.currentItem?.asset.duration
//        var getDurationString = DateComponentsFormatter.positional.string(from:CMTimeGetSeconds(duration!))
//
//        return
    
    /// { GET } url: String
    /// IF check if preDownloadedURL != url
    /// { Do } create player from async Data, .play()
    /// ELSE playPreDownloaded()
//    func startPlayerStream(url: String) {
//         if preDownloadedURL != url {
//            self.isLoadedBefore = false
//            guard let url = URL(string: url) else {
//                print("Bad track URL")
//                return
//            }
//
//            do {
//                self.isDownloaded = false
//                //разрешает играть есть в беззвучном режиме.
//                try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
//                try AVAudioSession.sharedInstance().setActive(true)
//
//                DispatchQueue.global().async {
//                    let data = try! Data(contentsOf: url)
//                    DispatchQueue.main.async { [weak self] in
//                        self?.player = try! AVAudioPlayer(data: data)
//                        self?.player?.prepareToPlay()
//                        self?.player?.play()
//                        print("play from startStream")
//                        self?.isPlaying = true
//                        self?.isDownloaded = true
//                    }
//                }
//                //            player = try AVAudioPlayer(contentsOf: url)
//
//            } catch let error {
//                print("Can't create player from url \(error.localizedDescription)")
//            }
//        }
//        else {
////            #warning вот это проверь
//            if isDownloaded == true {
//                self.player?.play()
//            } else {
//                playPreDownloaded()
//            }
//        }
//    }
    
    /// { GET } url String
    /// self change preDownloadedURL string
    /// guard if URL
    /// { SET } self.player & prepare to play
    /// print( "play from predownload")
    /// - Parameter url: <#url description#>
//    func preDownload(url: String) {
//        preDownloadedURL = url
//        guard
//            let url = URL(string: url)
//        else {
//            print("Bad track URL")
//            return
//        }
//        do {
//            //разрешает играть есть в беззвучном режиме.
//            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
//            try AVAudioSession.sharedInstance().setActive(true)
//            self.isDownloaded = false
//                DispatchQueue.global().async { [weak self] in
//                    guard
//                       let data = try? Data(contentsOf: url)
//                    else {
//                        self?.somethingBad = true
//                        print("Something bad == true ")
//                        return
//                    }
//                    DispatchQueue.main.async {
//                        self?.player = try! AVAudioPlayer(data: data)
//                        self?.player?.prepareToPlay()
//                        self?.isDownloaded = true
//                        if self?.isLoadedBefore  == true {
//                            self?.player?.play()
//                            self?.isPlaying = true
//                        }
//                        print("play from predownload")
//                    }
//                }
//        } catch let error {
//            print("Can't create player from url \(error.localizedDescription)")
//        }
//
//    }
    
//    func playPreDownloaded() {
//        self.isLoadedBefore = true
//           if var player = self.player {
//               player.play()
//               self.isPlaying = true
////               self.isDownloaded = true
//           }
//       }
    
//    func startPlayer(name: String) {
//        guard
//        let url = Bundle.main.url(forResource: name, withExtension: "mp3")
//        else {
//            print("Resource not found for :\(name)")
//            return
//        }
//        do {
//            //разрешает играть есть в беззвучном режиме.
//            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
//            try AVAudioSession.sharedInstance().setActive(true)
//            player = try AVAudioPlayer(contentsOf: url)
//            player?.prepareToPlay()
//            player?.play()
//            self.isDownloaded = true
//        } catch let error {
//            print("Can't create player from url \(error.localizedDescription)")
//        }
//
//
//    }
    
//    func playPause() {
//        guard let player = player else {
//            print("Instance of audio player not found")
//            return
//        }
//        if player.isPlaying {
//            player.pause()
//            isPlaying = false
//        } else {
//            player.play()
//            isPlaying = true
//        }
//    }
    
//    func stop() {
//        guard let player = player else {
//            return
//        }
//        if player.isPlaying {
//            player.stop()
//        }
//    }
//
//    func getPlayerTime() -> Double {
//        guard let player = player else {
//            return 0
//        }
//        return player.currentTime
//    }
//
//    // player looping if number of loops = -1
//    func toggleLoop() {
//        guard let player = player else { return }
//        player.numberOfLoops = player.numberOfLoops == 0 ? -1 : 0
//        isLoop = player.numberOfLoops != 0
//    }
}
