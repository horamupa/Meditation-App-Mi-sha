//
//  AuthViewViewModel.swift
//  Trip Map
//
//  Created by MM on 22.05.2023.
//

import SwiftUI
import FirebaseAuth

class AuthViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    
    func signIn() {
        print("button pressed")
        guard !email.isEmpty && !password.isEmpty else {
            print("bad auth data from user")
            return
        }
        
        Task {
            do {
                let returnedUserData = try await AuthBoy.share.createUser(email: email, password: password)
                print(returnedUserData)
                print("Auth Success")
            } catch {
                print("Error \(error)" )
            }
        }
    }
}
