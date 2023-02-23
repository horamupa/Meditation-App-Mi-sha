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
    
    static var shared = DataManager()
    
    private init () {
        loadDataFromFirestore()
    }
    
    func loadDataFromFirestore() {
        Firestore.firestore().collection("MainCourses").getDocuments { snapshot, error in
            if let error = error {
                print("Error get data from Firebase. Error: \(error.localizedDescription)")
            } else {
                if let snapshot = snapshot {
                    for document in snapshot.documents {
                        let name = document.data()["name"] as? String ?? "Error grab a name"
                        let image = document.data()["image"] as? String ?? "Error grab an image"
                        let lessons = document.data()["audio"] as? [String : [String:Any]]
                        let color = document.data()["color"] as? String ?? "Error grab a color"
                        var fetchedLessons = [TrackModel]()
                        if let lessons = lessons {
                            for lesson in lessons {
                                let lessonName = lesson.value["name"] as? String ?? "Error name"
                                let lessonID = lesson.value["id"] as? String ?? "Error id"
                                let lessonDuration = lesson.value["duration"] as? TimeInterval ?? 0.00
                                let lessonURL = lesson.value["url"] as? String ?? "Error url"
                                let lessonImage = lesson.value["image"] as? String ?? "Error image"
                                let lessonNumber = lesson.value["number"] as? Int ?? 0
                                fetchedLessons.append(TrackModel(id: lessonID, name: lessonName, duration: lessonDuration, image: lessonImage, url: lessonURL, number: lessonNumber))
                            }
                        }
                        self.courses.append(CourseModel(name: name, image: image, tracks: fetchedLessons, color: color))
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
    
}
