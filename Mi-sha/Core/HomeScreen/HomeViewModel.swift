import SwiftUI
import AVKit
import Combine

class HomeViewModel: ObservableObject {
    
    @Published var courses: [CourseModel] = []
    @Published var meditationList: [TrackModel] = []
    var manager = DataManager.shared
    var cancellables = Set<AnyCancellable>()
    
    init() {
        getCourses()
    }

    func getCourses() {
        manager.$courses
            .sink { [weak self] fetchedCourses in
                self?.courses = fetchedCourses
            }
            .store(in: &cancellables)
    }
    
    func actualLesson() -> TrackModel? {
        guard courses.count > 0 else {
            print("Bad count")
            return nil }
        var lessons: [TrackModel] = []
        for course in courses {
            for trackNew in course.tracks {
                lessons.append(trackNew)
            }
        }
        let lesson = lessons.first(where: { $0.number == UserProgress.shared.nextMeditation()})
        return lesson
    }
}
