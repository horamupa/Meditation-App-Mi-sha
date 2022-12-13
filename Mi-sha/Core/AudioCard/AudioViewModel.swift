//
//  MeditationViewModel.swift
//  Mi-sha
//
//  Created by MM on 08.12.2022.
//

import SwiftUI
import AVKit

class AudioViewModel: ObservableObject {
    
    @Published var meditationList: [AudioModel] = []
    
    init() {
        self.meditationList = getData()
    }
    
    func getData() -> [AudioModel] {
        let fetchedData = [
            AudioModel(id: "1", name: "1 minute relaxing meditation", duration: 70, description: "Best Meditation You Ever Heard", image: "stones"),
            AudioModel(id: "2", name: "2 minute relaxing meditation", duration: 70, description: "Second Best Meditation You Ever Heard", image: "stones"),
            AudioModel(id: "3", name: "3 minute relaxing meditation", duration: 70, description: "Second Best Meditation You Ever Heard", image: "stones")
        ]
        
        return fetchedData
    }
}
