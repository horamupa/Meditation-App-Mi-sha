import SwiftUI
import AVKit
import Combine

class HomeViewModel: ObservableObject {
    
    @Published var courses: [CourseModel] = []
    @Published var meditationList: [TrackModel] = []
    var manager = DataManager.shared
    var cancellables = Set<AnyCancellable>()
    
    init() {
        self.meditationList = getData()
        getCourses()
    }
    
    func getData() -> [TrackModel] {
        let fetchedData = [
            TrackModel(id: "1", name: "1 minute relaxing meditation", duration: 70, image: "stones"),
            TrackModel(id: "2", name: "2 minute relaxing meditation", duration: 70, image: "stones"),
            TrackModel(id: "3", name: "3 minute relaxing meditation", duration: 70, image: "stones")
        ]
        
        return fetchedData
    }
    
    func getCourses() {
        manager.$courses
            .sink { [weak self] fetchedCourses in
                self?.courses = fetchedCourses
            }
//            .cancel()
            .store(in: &cancellables)
    }
}
