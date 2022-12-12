//
//  AudioManager.swift
//  Mi-sha
//
//  Created by MM on 12.12.2022.
//

import SwiftUI
import AVKit

class AudioManager {
    
    static var share = AudioManager()
    var player: AVAudioPlayer?
    
    private init() { }
    
    func startPlayer(name: String) {
        guard
        let url = Bundle.main.url(forResource: name, withExtension: ".mp3")
        else {
            print("Error URL name")
            return
        }
        do {
            player = try AVAudioPlayer(contentsOf: url)
        } catch let error { print("Can't create player from url \(error.localizedDescription)") }
        player?.play()
    }
}
