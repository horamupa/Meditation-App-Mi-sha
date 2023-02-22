//
//  CourseModel.swift
//  Mi-sha
//
//  Created by MM on 15.12.2022.
//

import SwiftUI

struct CourseModel: Hashable, Identifiable {
    var id = UUID()
    var name: String
    var image: String
    var tracks: [TrackModel]
    var color: String
    
    var course: CourseModel {
        CourseModel(name: "Gentle Beggining", image: "stones", tracks: [TrackModel.track,TrackModel.track,TrackModel.track], color: "smollDoggo")
    }
}
