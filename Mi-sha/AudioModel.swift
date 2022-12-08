//
//  MeditationModel.swift
//  Mi-sha
//
//  Created by MM on 08.12.2022.
//

import SwiftUI

struct AudioModel: Codable, Hashable, Identifiable {
    let id: String
    let name: String
    let duration: String
    let description: String
    var isListen: Bool
    
    init(id: String, name: String, duration: String, description: String, isListen: Bool = false) {
        self.id = id
        self.name = name
        self.duration = duration
        self.description = description
        self.isListen = isListen
    }
}
