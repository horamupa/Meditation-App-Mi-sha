//
//  MeditationViewModel.swift
//  Mi-sha
//
//  Created by MM on 08.12.2022.
//

import SwiftUI
import AVKit

class AudioViewModel: ObservableObject {
    
    @Published var meditationList: [TrackModel] = []
    
    init() {
        self.meditationList = getData()
    }
    
    func getData() -> [TrackModel] {
        let fetchedData = [
            TrackModel(id: "1", name: "1 minute relaxing meditation", duration: 70, image: "stones", number: 1),
            TrackModel(id: "2", name: "2 minute relaxing meditation", duration: 70, image: "stones", number: 2),
            TrackModel(id: "3", name: "3 minute relaxing meditation", duration: 70, image: "stones", number: 3)
        ]
        
        return fetchedData
    }
}
