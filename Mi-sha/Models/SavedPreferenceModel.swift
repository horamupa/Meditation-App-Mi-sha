//
//  SavedPreferenceModel.swift
//  Mi-sha
//
//  Created by MM on 26.12.2022.
//

import Foundation

class SavedPreferenceModel: Comparable, Codable {
    
    static func == (lhs: SavedPreferenceModel, rhs: SavedPreferenceModel) -> Bool {
        lhs.number == rhs.number
    }
    
    
    static func < (lhs: SavedPreferenceModel, rhs: SavedPreferenceModel) -> Bool {
        lhs.number < rhs.number
    }
    
    let number: Int
    var done: Bool
    
    init(number: Int, done: Bool = false) {
        self.number = number
        self.done = done
    }
    
}
