//
//  LoginView.swift
//  Mi-sha
//
//  Created by MM on 13.12.2022.
//

import SwiftUI

struct LoginView: View {
    
    @State var email: String = ""
    @State var password: String = ""
    var body: some View {
        ZStack {
            Color.theme.black
            
            VStack(spacing: 20) {
                Text("Welcome")
                    .foregroundColor(.white)
                    .font(.system(size: 40, weight: .bold, design: .rounded))
                TextField("Email", text: $email)
                Rectangle()
                    .frame(width: 350, height: 1)
                TextField("Password", text: $password)
                    .frame(width: 350, height: 1)
                Button {
                    
                } label: {
                    Text("Sign up")
                        .foregroundColor(.blue)
                        .bold()
                        .frame(width: 200, height: 40)
                        .background {
                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                             
                        }
                    
                }
                
                Button {
                    
                } label: {
                    Text("Already have an acount? Login")
                        .bold()
                }

            }
            .padding(30)
            .foregroundColor(.white)
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
