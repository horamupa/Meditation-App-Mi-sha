//
//  Mi_shaApp.swift
//  Mi-sha
//
//  Created by MM on 08.12.2022.
//

import SwiftUI
import Firebase
import FirebaseCore


@main
struct Mi_shaApp: App {
    init() {
        FirebaseApp.configure()
    }
    @AppStorage("signed_in") var currentUserSignedIn: Bool = false
    @StateObject var vm = HomeViewModel()
    @StateObject var audioManager = AudioManager()
    @StateObject var userProgress = UserProgress()
    @StateObject var dataManager = DataManager()
    
    var body: some Scene {
        WindowGroup {
            if !currentUserSignedIn { // Onbording or CustomLoadView
                OnboardingView()
            } else {
                NavigationView {
                    if vm.courses.count > 0 {
                        HomeView(container: AppDependency(dataManager: dataManager, audioManager: audioManager, userProgress: userProgress, vm: vm))
                            .environmentObject(vm)
                            .environmentObject(audioManager)
                    } else {
                        CustomLoadingView()
                    }
                }
            }
        }
    }
}
