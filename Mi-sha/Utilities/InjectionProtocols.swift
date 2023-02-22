//
//  Protocols.swift
//  Mi-sha
//
//  Created by MM on 11.01.2023.
//

import SwiftUI

protocol DataManagerProtocol {
    var dataManager: DataManager { get }
}

protocol AudioManagerProtocol {
    var audioManager: AVManager { get }
}

protocol UserProgressProtocol {
    var userProgress: UserProgress { get }
}

protocol ViewModeProtocol {
    var vm: HomeViewModel { get }
}

struct AppDependency: DataManagerProtocol, AudioManagerProtocol, UserProgressProtocol, ViewModeProtocol {
    var dataManager: DataManager
    var audioManager: AVManager
    var userProgress: UserProgress
    var vm: HomeViewModel
}
