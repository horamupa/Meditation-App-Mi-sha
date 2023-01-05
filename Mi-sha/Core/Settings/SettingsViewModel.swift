//
//  SettingsViewModel.swift
//  Mi-sha
//
//  Created by MM on 28.12.2022.
//

import SwiftUI

class SettingsViewModel: ObservableObject {
    
    @Published var userProfile: ProfileModel
//userName: "Юный друг", userImage: "home1", userTotalTime: 0, userTotalDays: 0, userBestStreak: 0, userLastSeen: Date.now)
    var manager = DataManager.shared
    
    init() {
        userProfile = manager.userProfile
    }
    
    func saveName(name:String) {
        if name != "" {
            manager.userProfile.userName = name
            userProfile = manager.userProfile
        }
        else { return }
    }
    
    
//    func saveUserProfile() {
//        let settings = self.userProfile
//        guard let encoder = try? JSONEncoder().encode(settings) else { return }
//        UserDefaults.standard.set(encoder, forKey: "user_profile_info")
//    }
//    
//    func setUserProfile() {
//        guard let data = UserDefaults.standard.data(forKey: "user_profile_info"),
//              let decodedData = try? JSONDecoder().decode(ProfileModel.self, from: data)
//        else { return }
//        self.userProfile = decodedData
//    }
}
