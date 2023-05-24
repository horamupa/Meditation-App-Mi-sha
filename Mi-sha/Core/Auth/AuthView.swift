//
//  AuthView.swift
//  Мёöт
//
//  Created by MM on 22.05.2023.
//

import SwiftUI

struct AuthView: View {
    
    @StateObject var vm = AuthViewModel()
    var body: some View {
        
        TextField("Email", text: $vm.email)
        TextField("Password", text: $vm.password) //min 6 char
        
        Button("Create User with email") {
            vm.signIn()
        }
        .onAppear {
            let authUser = try? AuthBoy.share.getAuthenticatedUser()
            
        }
    }
}

struct AuthView_Previews: PreviewProvider {
    static var previews: some View {
        AuthView()
    }
}
