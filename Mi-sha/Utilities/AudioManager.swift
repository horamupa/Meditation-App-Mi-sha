//
//  AudioManager.swift
//  Mi-sha
//
//  Created by MM on 12.12.2022.
//

import SwiftUI
import AVKit

class AudioManager: ObservableObject {
    
    @Published var player: AVAudioPlayer?
    @Published private var isPlaying: Bool = false {
        didSet {
            print("isPlaying", isPlaying)
        }
    }
    @Published var isLoop = false
    var preDownloadedURL = ""
    
    static var shared = AudioManager()
    var dataManager = DataManager.shared
    
    private init() { }
    
    func startPlayerStream(url: String) {
        
        if preDownloadedURL != url {
            
            guard
                let url = URL(string: url)
            else {
                print("Bad track URL")
                return
            }
            do {
                //разрешает играть есть в беззвучном режиме.
                try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
                try AVAudioSession.sharedInstance().setActive(true)
                
                DispatchQueue.global().async {
                    let data = try! Data(contentsOf: url)
                    DispatchQueue.main.async {
                        self.player = try! AVAudioPlayer(data: data)
                        self.player?.prepareToPlay()
                        self.player?.play()
                        self.isPlaying = true
                    }
                }
                //            player = try AVAudioPlayer(contentsOf: url)
                
            } catch let error {
                print("Can't create player from url \(error.localizedDescription)")
            }
        }
        else {
            playPreDownloaded()
        }
    }
    
    func preDownload(url: String) {
        preDownloadedURL = url
        guard
            let url = URL(string: url)
        else {
            print("Bad track URL")
            return
        }
        do {
            //разрешает играть есть в беззвучном режиме.
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            
                DispatchQueue.global().async {
                    let data = try! Data(contentsOf: url)
                    DispatchQueue.main.async {
                        self.player = try! AVAudioPlayer(data: data)
                        self.player?.prepareToPlay()
                    }
                }
        } catch let error {
            print("Can't create player from url \(error.localizedDescription)")
        }
        
    }
    
    func playPreDownloaded() {
        self.player?.play()
        self.isPlaying = true
    }
    
    func startPlayer(name: String) {
        guard
        let url = Bundle.main.url(forResource: name, withExtension: "mp3")
        else {
            print("Resource not found for :\(name)")
            return
        }
        do {
            //разрешает играть есть в беззвучном режиме.
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            player = try AVAudioPlayer(contentsOf: url)
        } catch let error {
            print("Can't create player from url \(error.localizedDescription)")
        }
        player?.play()
        isPlaying = true
    }
    
    func playPause() {
        guard let player = player else {
            print("Instance of audio player not found")
            return
        }
        if player.isPlaying {
            player.pause()
            isPlaying = false
        } else {
            player.play()
            isPlaying = true
        }
    }
    
    func stop() {
        guard let player = player else {
            return
        }
        if player.isPlaying {
            player.stop()
        }
    }
    
    // player looping if number of loops = -1
    func toggleLoop() {
        guard let player = player else { return }
        player.numberOfLoops = player.numberOfLoops == 0 ? -1 : 0
        isLoop = player.numberOfLoops != 0
    }
}
