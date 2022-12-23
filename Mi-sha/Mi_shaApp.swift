//
//  Mi_shaApp.swift
//  Mi-sha
//
//  Created by MM on 08.12.2022.
//

import SwiftUI
import Firebase
import FirebaseCore

//class AppDelegate: NSObject, UIApplicationDelegate {
//  func application(_ application: UIApplication,
//                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
//    FirebaseApp.configure()
//
//    return true
//  }
//}

@main
struct Mi_shaApp: App {
//    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    init() {
        FirebaseApp.configure()
    }
    @AppStorage("signed_in") var currentUserSignedIn: Bool = false
    @StateObject var vm = HomeViewModel()
    @StateObject var audioManager = AudioManager.shared
    var body: some Scene {
        WindowGroup {
            if !currentUserSignedIn {
                OnboardingView()
            } else {
                NavigationView {
                    HomeView()
                        .environmentObject(vm)
                        .environmentObject(audioManager)
                }
            }
        }
    }
}
