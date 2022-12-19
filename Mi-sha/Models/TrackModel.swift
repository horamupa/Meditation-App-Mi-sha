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
//    let description: String
    var isListen: Bool
    let image: String?
    let url: String
    
    init(id: String, name: String, duration: TimeInterval, isListen: Bool = false, image: String?, url: String = "") {
        self.id = id
        self.name = name
        self.duration = duration
//        self.description = description
        self.isListen = isListen
        self.image = image
        self.url = url
    }
    
   static let track = TrackModel(id: "1", name: "1 minute relaxing meditation", duration: 70, image: "stones")
    
}
