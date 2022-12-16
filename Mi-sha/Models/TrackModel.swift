//
//  MeditationModel.swift
//  Mi-sha
//
//  Created by MM on 08.12.2022.
//

import SwiftUI

struct TrackModel: Codable, Hashable, Identifiable {
    let id: String
    let name: String
    let duration: TimeInterval
    let description: String
    var isListen: Bool
    let image: String?
    
    init(id: String, name: String, duration: TimeInterval, description: String, isListen: Bool = false, image: String?) {
        self.id = id
        self.name = name
        self.duration = duration
        self.description = description
        self.isListen = isListen
        self.image = image
    }
    
   static let track = TrackModel(id: "1", name: "1 minute relaxing meditation", duration: 70, description: "Best Meditation You Ever Heard", image: "stones")
    
}
