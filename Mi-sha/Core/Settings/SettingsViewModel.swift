//
//  SettingsViewModel.swift
//  Mi-sha
//
//  Created by MM on 28.12.2022.
//

import SwiftUI

class SettingsViewModel: ObservableObject {
    
    @Published var userProfile = ProfileModel(userName: "Искатель приключений", userImage: "home1", userTotalTime: 30, userTotalDays: 10, userBestStreak: 3)
    
}
