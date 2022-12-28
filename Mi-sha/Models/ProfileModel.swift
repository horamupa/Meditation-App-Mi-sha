//
//  ProfileModel.swift
//  Mi-sha
//
//  Created by MM on 28.12.2022.
//

import SwiftUI

struct ProfileModel: Codable {
    
    var userName: String
    var userImage: String
    var userTotalTime: Double
    var userTotalDays: Int
    var userBestStreak: Int
    
}
