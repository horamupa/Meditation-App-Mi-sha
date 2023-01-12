//
//  ProgressInfoDictionary.swift
//  Mi-sha
//
//  Created by MM on 23.12.2022.
//

import SwiftUI

class UserProgress: ObservableObject {
    
    @Published var courseProgress: [SavedPreferenceModel] = [
        SavedPreferenceModel(number: "1", done: false),
        SavedPreferenceModel(number: "2", done: false),
        SavedPreferenceModel(number: "3", done: false),
        SavedPreferenceModel(number: "4", done: false),
        SavedPreferenceModel(number: "5", done: false),
        SavedPreferenceModel(number: "6", done: false),
        SavedPreferenceModel(number: "7", done: false),
        SavedPreferenceModel(number: "8", done: false),
        SavedPreferenceModel(number: "9", done: false),
        SavedPreferenceModel(number: "10", done: false),
        SavedPreferenceModel(number: "11", done: false),
        SavedPreferenceModel(number: "12", done: false),
        SavedPreferenceModel(number: "13", done: false),
        SavedPreferenceModel(number: "14", done: false),
        SavedPreferenceModel(number: "15", done: false),
        SavedPreferenceModel(number: "16", done: false),
        SavedPreferenceModel(number: "17", done: false),
        SavedPreferenceModel(number: "18", done: false),
        SavedPreferenceModel(number: "19", done: false),
        SavedPreferenceModel(number: "20", done: false),
        SavedPreferenceModel(number: "21", done: false),
        SavedPreferenceModel(number: "22", done: false),
        SavedPreferenceModel(number: "23", done: false),
        SavedPreferenceModel(number: "24", done: false),
        SavedPreferenceModel(number: "25", done: false),
        SavedPreferenceModel(number: "26", done: false),
        SavedPreferenceModel(number: "27", done: false),
        SavedPreferenceModel(number: "28", done: false),
        SavedPreferenceModel(number: "29", done: false),
        SavedPreferenceModel(number: "30", done: false)
    ]
    
    @Published var nextMeditationNum = "0"
    
    
    static var shared = UserProgress()
    
    init() {
        print(self.courseProgress.first?.number)
        print(self.courseProgress.first?.done)
        setPreference()
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
    
    /// set metric/american style preference
    func setPreference() {
        guard let data = UserDefaults.standard.data(forKey: "save_it"),
              let decodedData = try? JSONDecoder().decode([SavedPreferenceModel].self, from: data)
        else { return }
        // надо сравнить каждую ячейку и добавить к кей значение
        self.courseProgress = decodedData.sorted()
    }
    
    func nextMeditation() -> String {
        let num: Int = (Int(nextMeditationNum) ?? 0) + 1
        return String(num)
    }
    
    
}
