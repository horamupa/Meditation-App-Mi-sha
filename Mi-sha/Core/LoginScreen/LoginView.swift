//
//  LoginView.swift
//  Mi-sha
//
//  Created by MM on 13.12.2022.
//

import SwiftUI
import Firebase

struct LoginView: View {
    
    @State var email: String = ""
    @State var password: String = ""
    @State private var userIsLoggedIn = false
    
    var body: some View {
        ZStack {
            Color.theme.black
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                Text("Welcome")
                    .foregroundColor(.white)
                    .font(.system(size: 40, weight: .bold, design: .rounded))
                TextField("Email", text: $email)
                    .padding(.top, 20)
                    .placeholder(when: email.isEmpty) {
                        Text("Enter your email")
                            .opacity(0.7)
                    }
                Rectangle()
                    .frame(width: 350, height: 1)
                SecureField("Password", text: $password)
                    .frame(width: 350, height: 1)
                    .placeholder(when: email.isEmpty) {
                        Text("Enter your password")
                            .opacity(0.7)
                    }
                Button {
                   register()
                } label: {
                    Text("Sign up")
                        .foregroundColor(.blue)
                        .bold()
                        .frame(width: 200, height: 40)
                        .background {
                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                        }
                    
                }
                .padding(.top, 10)
                Button {
                    login()
                } label: {
                    Text("Already have an acount? Login")
                        .bold()
                }

            }
            .padding(30)
            .foregroundColor(.white)
        }
//        .onAppear {
//            Auth.auth().addStateDidChangeListener { auth, user in
//                if user != nil {
////                    userisloggedin.toggle
//                }
//            }
//        }
    }
    
    func login() {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
    func register() {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
