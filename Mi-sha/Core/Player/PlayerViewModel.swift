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
    
    typealias Dependencies = AudioManagerProtocol & DataManagerProtocol & UserProgressProtocol
    
    @Published var audioManager: AudioManager
    @Published var manager: DataManager
    @Published var userProgress: UserProgress
    @Published var playerTime: Double = 0.0
    var model: TrackModel
    
    init(model: TrackModel, container: Dependencies) {
        self.model = model
        self.audioManager = container.audioManager
        self.manager = container.dataManager
        self.userProgress = container.userProgress
    }
    
    
    let timer = Timer
        .publish(every: 0.5, on: .main, in: .common)
        .autoconnect()
    
    func checkProgress() {
        if audioManager.getPlayerTime() > 420 {
            userProgress.updateProgress(model: model)
            userProgress.savePreference()
            manager.userProfile.userTotalTime += audioManager.getPlayerTime()
            manager.userProfile.userTotalDays += 1
        }
    }
    
    func startOnAppear() {
        let storage = Storage.storage().reference(forURL: model.url)
         storage.downloadURL { url, error in
             if let error = error {
                 print("Error download from the firebase. \(error.localizedDescription)")
                 self.audioManager.startPlayer(name: "1")
             } else {
                 self.audioManager.startPlayerStream(url: self.model.url)
                 print("player Succes")

             }
         }
    }
}
