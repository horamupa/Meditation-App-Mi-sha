//
//  Mi_shaApp.swift
//  Mi-sha
//
//  Created by MM on 08.12.2022.
//

import SwiftUI
import Firebase



@main
struct Mi_shaApp: App {
    
    init() {
        FirebaseApp.configure()
    }
    
    @StateObject var vm = HomeViewModel()
    @StateObject var audioManager = AudioManager()
    var body: some Scene {
        WindowGroup {
            NavigationView {
                HomeView()
                    .environmentObject(vm)
                    .environmentObject(audioManager)
            }
        }
    }
}
