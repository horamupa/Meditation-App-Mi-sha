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
                                fetchedLessons.append(TrackModel(id: lessonID, name: lessonName, duration: lessonDuration, image: lessonImage, url: lessonURL))
                            }
                        }
                        self.courses.append(CourseModel(name: name, image: image, tracks: fetchedLessons))
                    }
                }
            }
            
        }
        print(self.courses)
    }
    
}
