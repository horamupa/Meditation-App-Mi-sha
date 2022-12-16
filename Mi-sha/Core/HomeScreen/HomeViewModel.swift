import SwiftUI
import AVKit

class HomeViewModel: ObservableObject {
    
    @Published var courses: [CourseModel] = []
    @Published var meditationList: [TrackModel] = []
    
    init() {
        self.meditationList = getData()
        self.courses = getCourses()
    }
    
    func getData() -> [TrackModel] {
        let fetchedData = [
            TrackModel(id: "1", name: "1 minute relaxing meditation", duration: 70, description: "Best Meditation You Ever Heard", image: "stones"),
            TrackModel(id: "2", name: "2 minute relaxing meditation", duration: 70, description: "Second Best Meditation You Ever Heard", image: "stones"),
            TrackModel(id: "3", name: "3 minute relaxing meditation", duration: 70, description: "Second Best Meditation You Ever Heard", image: "stones")
        ]
        
        return fetchedData
    }
    
    func getCourses() -> [CourseModel] {
        
        var addCourses = [CourseModel]()
        for i in 0..<3 {
            addCourses.append(CourseModel(name: "Course \(String(i))", image: "Color\(i)", tracks: [TrackModel.track]))
        }
        return addCourses
        
    }
}
