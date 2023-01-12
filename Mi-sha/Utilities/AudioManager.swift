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
    var isDownloaded = false
    
    static var shared = AudioManager()
    var dataManager = DataManager.shared
    var somethingBad = false
    
    init() { }
    
    func startPlayerStream(url: String) {
         if !isDownloaded {
            
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
                    guard
                       let data = try? Data(contentsOf: url)
                    else {
                        self.somethingBad = true
                        print("Something bad == true ")
                        return
                    }
                    DispatchQueue.main.async {
                        self.player = try! AVAudioPlayer(data: data)
                        self.player?.prepareToPlay()
                        self.isDownloaded = true
                    }
                }
        } catch let error {
            print("Can't create player from url \(error.localizedDescription)")
        }
        
    }
    
    func playPreDownloaded() {
        if let player = self.player {
            player.play()
            self.isPlaying = true
        }
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
            player?.prepareToPlay()
            player?.play()
            self.isDownloaded = true
        } catch let error {
            print("Can't create player from url \(error.localizedDescription)")
        }
        
        
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
    
    func getPlayerTime() -> Double {
        guard let player = player else {
            return 0
        }
        return player.currentTime
    }
    
    // player looping if number of loops = -1
    func toggleLoop() {
        guard let player = player else { return }
        player.numberOfLoops = player.numberOfLoops == 0 ? -1 : 0
        isLoop = player.numberOfLoops != 0
    }
}
