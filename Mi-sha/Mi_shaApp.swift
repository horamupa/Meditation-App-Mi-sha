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
    @State var isShowOnboarding: Bool = true
    @StateObject var vm = HomeViewModel()
    @StateObject var audioManager = AVManager.shared
    @StateObject var userProgress = UserProgress.shared
    @StateObject var dataManager = DataManager.shared
    
    var body: some Scene {
        WindowGroup {
            if !currentUserSignedIn && isShowOnboarding { // Onbording or CustomLoadView
                OnboardingView(isShowOnboarding: $isShowOnboarding)
            } else {
                NavigationView {
                    if vm.courses.count > 0 {
                        HomeView()
                            .environmentObject(vm)
                            .environmentObject(audioManager)
                    } else {
                        CustomLoadingView()
                    }
                }
                .accentColor(.black)
            }
//            AuthView()
        }
    }
}
