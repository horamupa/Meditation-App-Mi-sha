//
//  ProgressInfoDictionary.swift
//  Mi-sha
//
//  Created by MM on 23.12.2022.
//

import SwiftUI

class UserProgress: ObservableObject {
    
    @Published var courseProgress: [SavedPreferenceModel] = [
        SavedPreferenceModel(number: 1, done: false),
        SavedPreferenceModel(number: 2, done: false),
        SavedPreferenceModel(number: 3, done: false),
        SavedPreferenceModel(number: 4, done: false),
        SavedPreferenceModel(number: 5, done: false),
        SavedPreferenceModel(number: 6, done: false),
        SavedPreferenceModel(number: 7, done: false),
        SavedPreferenceModel(number: 8, done: false),
        SavedPreferenceModel(number: 9, done: false),
        SavedPreferenceModel(number: 10, done: false),
        SavedPreferenceModel(number: 11, done: false),
        SavedPreferenceModel(number: 12, done: false),
        SavedPreferenceModel(number: 13, done: false),
        SavedPreferenceModel(number: 14, done: false),
        SavedPreferenceModel(number: 15, done: false),
        SavedPreferenceModel(number: 16, done: false),
        SavedPreferenceModel(number: 17, done: false),
        SavedPreferenceModel(number: 18, done: false),
        SavedPreferenceModel(number: 19, done: false),
        SavedPreferenceModel(number: 20, done: false),
        SavedPreferenceModel(number: 21, done: false),
        SavedPreferenceModel(number: 22, done: false),
        SavedPreferenceModel(number: 23, done: false),
        SavedPreferenceModel(number: 24, done: false),
        SavedPreferenceModel(number: 25, done: false),
        SavedPreferenceModel(number: 26, done: false),
        SavedPreferenceModel(number: 27, done: false),
        SavedPreferenceModel(number: 28, done: false),
        SavedPreferenceModel(number: 29, done: false),
        SavedPreferenceModel(number: 30, done: false)
    ]
    @Published var userProfile = ProfileModel(userName: "Друг зверей", userImage: "home1", userTotalTime: 0, userTotalDays: 0, userBestStreak: 0, userLastSeen: Date.now)
    @Published var nextMeditationNum = 0
    
    
    static var shared = UserProgress()
    
    private init() {
        setPreference()
        setUserProfile()
    }
    
    func updateProgress(model: TrackModel) {
        nextMeditationNum = model.number
        var updateLesson = self.courseProgress.first(where: { $0.number == model.number } )
        updateLesson?.done = true
        savePreference()
    }
    
    func checkDone(model: TrackModel) -> Bool {
        var updateLesson = self.courseProgress.first(where: { $0.number == model.number } )
        if updateLesson?.done == true {
            return true
        } else {
            return false
        }
    }
    
    func savePreference() {
        let settings = self.courseProgress
        guard let encoder = try? JSONEncoder().encode(settings) else { return }
        UserDefaults.standard.set(encoder, forKey: "save_it")
    }
    
    func setPreference() {
        guard let data = UserDefaults.standard.data(forKey: "save_it"),
              let decodedData = try? JSONDecoder().decode([SavedPreferenceModel].self, from: data)
        else { return }
        // надо сравнить каждую ячейку и добавить к кей значение
        self.courseProgress = decodedData.sorted()
    }
    
    
    func nextMeditation() -> Int {
        let notDone = self.courseProgress.sorted().first(where: { $0.done == false } )
        return notDone?.number ?? 0
    }
    
    // Profile func
    func saveUserProfile() {
        let settings = self.userProfile
        guard let encoder = try? JSONEncoder().encode(settings) else { return }
        UserDefaults.standard.set(encoder, forKey: "user_profile_info")
    }
    
    func setUserProfile() {
        guard let data = UserDefaults.standard.data(forKey: "user_profile_info"),
              let decodedData = try? JSONDecoder().decode(ProfileModel.self, from: data)
        else { return }
        self.userProfile = decodedData
    }
    
    func changeSettings(userName: String?, userImage: String?, userTotalTime: Double?, userTotalDays: Int?, userBestStreak: Int?) {
        if let userName = userName { self.userProfile.userName = userName }
        if let userImage = userImage { self.userProfile.userImage = userImage }
        if let userTotalTime = userTotalTime { self.userProfile.userTotalTime = userTotalTime }
        if let userTotalDays = userTotalDays { self.userProfile.userTotalDays = userTotalDays }
        if let userBestStreak = userBestStreak { self.userProfile.userBestStreak = userBestStreak }
        saveUserProfile()
        setUserProfile()
    }
    
    func dateChecker() {
        
        var calendar = Calendar.current
        calendar.timeZone = TimeZone(identifier: "UTC")!
        if self.userProfile.userBestStreak == 0 {
            self.userProfile.userBestStreak += 1
        } else {
            if calendar.isDateInYesterday(self.userProfile.userLastSeen) {
                self.userProfile.userBestStreak += 1
            }
            self.userProfile.userLastSeen = Date.now
        }
        saveUserProfile()
        setUserProfile()
    }
    
    func totalDaysChek() {
        var calendar = Calendar.current
        calendar.timeZone = TimeZone(identifier: "UTC")!
        if userProfile.userTotalDays == 0 {
            userProfile.userTotalDays += 1
        } else {
            if calendar.isDateInToday(self.userProfile.userLastSeen) {
                return
            } else { userProfile.userTotalDays += 1 }
        }
        saveUserProfile()
        setUserProfile()
    }
    
}
