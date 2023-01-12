//
//  DataManager.swift
//  Mi-sha
//
//  Created by MM on 19.12.2022.
//

import SwiftUI
import Firebase
import Combine

class DataManager: ObservableObject {
    
    @Published var courses: [CourseModel] = []
    @Published var userProfile = ProfileModel(userName: "Друг животных", userImage: "home1", userTotalTime: 0, userTotalDays: 0, userBestStreak: 0, userLastSeen: Date.now)
    
    static var shared = DataManager()
    
    init () {
        loadDataFromFirestore()
        setUserProfile()
    }
    
    func loadDataFromFirestore() {
        Firestore.firestore().collection("MainCourses").getDocuments { snapshot, error in
            if let error = error {
                print("Error get data from Firebase. Error: \(error.localizedDescription)")
            } else {
                if let snapshot = snapshot {
                    for document in snapshot.documents {
                        let name = document.data()["name"] as? String ?? "Error grab name"
                        let image = document.data()["image"] as? String ?? "Error grab image"
                        let lessons = document.data()["audio"] as? [String : [String:Any]]
                        
                        var fetchedLessons = [TrackModel]()
                        if let lessons = lessons {
                            for lesson in lessons {
                                let lessonName = lesson.value["name"] as? String ?? "Error name"
                                let lessonID = lesson.value["id"] as? String ?? "Error id"
                                let lessonDuration = lesson.value["duration"] as? TimeInterval ?? 0.00
                                let lessonURL = lesson.value["url"] as? String ?? "Error url"
                                let lessonImage = lesson.value["image"] as? String ?? "Error image"
                                let lessonNumber = lesson.value["number"] as? String ?? "Error FB number"
                                fetchedLessons.append(TrackModel(id: lessonID, name: lessonName, duration: lessonDuration, image: lessonImage, url: lessonURL, number: lessonNumber))
                            }
                        }
                        self.courses.append(CourseModel(name: name, image: image, tracks: fetchedLessons))
                    }
                }
            }
            
        }
        print(self.courses)
    }
    
    func downloadDataFromUrl(url: URL) async throws -> Data? {
 
        do {
            let (data, _) = try await URLSession(configuration: .default).data(from: url)
            return data
        } catch {
            throw error
        }
    }
    
    //MARK: Profile Save/Load Settings
    
    
    
    
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
        if calendar.isDateInYesterday(self.userProfile.userLastSeen) {
            self.userProfile.userBestStreak += 1
        }
        self.userProfile.userLastSeen = Date.now
        saveUserProfile()
        setUserProfile()

    }
    
}
