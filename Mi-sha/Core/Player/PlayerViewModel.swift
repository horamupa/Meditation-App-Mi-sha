//
//  PlayerViewModel.swift
//  Mi-sha
//
//  Created by MM on 11.01.2023.
//

import SwiftUI
import Combine
import Firebase
import FirebaseStorage
import AVKit

class PlayerViewModel: ObservableObject {
    
    @Published var audioManager = AVManager.shared //PLAyER
    @Published var userProgress = UserProgress.shared
    @Published var playerTime: Double = 0.0
    @Published var sliderProgress: Float = 0
    @Published var isPlaying: Bool = false
    var acceptProgressUpdates = true
    var model: TrackModel
    var subscriptions = Set<AnyCancellable>()
    
    
    init(model: TrackModel) {
        self.model = model
        listenToProgress()
    }
    
    
    let timer = Timer
        .publish(every: 0.5, on: .main, in: .common)
        .autoconnect()
    
    //Slider
    private func listenToProgress() {
        audioManager.currentProgressPublisher.sink { [weak self] progress in
               guard let self = self,
                     self.acceptProgressUpdates else { return }
               self.sliderProgress = progress
           }.store(in: &subscriptions)
       }
    
    func didSliderChanged(_ didChange: Bool) {
            acceptProgressUpdates = !didChange
            if didChange {
                audioManager.pause()
            } else {
                audioManager.seek(to: sliderProgress)
                audioManager.play()
            }
        }
    
    func checkProgress() {
        if audioManager.getStreamPlayerTime() ?? 0 > 420 {
            userProgress.updateProgress(model: model)
            userProgress.userProfile.userTotalTime += audioManager.getStreamPlayerTime() ?? 0
            userProgress.totalDaysChek()
            userProgress.dateChecker()
            userProgress.savePreference()
        }
    }
    
    func startOnAppear() {
        let storage = Storage.storage().reference(forURL: model.url)
         storage.downloadURL { url, error in
             if let error = error {
                 print("Error download from the firebase. \(error.localizedDescription)")
//                 self.audioManager.startPlayer(name: "1")
             } else {
                 self.audioManager.initPlayer(url: self.model.url)
//                 self.audioManager.startPlayerStream(url: self.model.url)
                 print("player Success")

             }
         }
    }
}
