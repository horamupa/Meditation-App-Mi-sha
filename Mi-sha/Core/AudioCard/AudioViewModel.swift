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
        self.meditationList.append(getData())
    }
    
    func getData() -> AudioModel {
        let fetchedData = AudioModel(id: "1", name: "1 minute relaxing meditation", duration: 70, description: "Best Meditation You Ever Heard", image: "stones")
        return fetchedData
    }
}
