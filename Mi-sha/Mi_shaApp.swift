//
//  Mi_shaApp.swift
//  Mi-sha
//
//  Created by MM on 08.12.2022.
//

import SwiftUI

@main
struct Mi_shaApp: App {
    @StateObject var vm = AudioViewModel()
    var body: some Scene {
        WindowGroup {
            NavigationView {
                HomeView()
                    .environmentObject(vm)
            }
        }
    }
}
