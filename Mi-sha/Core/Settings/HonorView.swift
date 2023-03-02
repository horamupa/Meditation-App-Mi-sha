//
//  Settings.swift
//  Mi-sha
//
//  Created by MM on 12.12.2022.
//

import SwiftUI

struct HonorView: View {
    
    @StateObject var vm = SettingsViewModel()
    
    //    @State var userName = "UserName"
    
    
    var termsOfService = URL(string: "https://docs.google.com/document/d/1-miKyQGkgExJxXlUCgyV2TYlnP08ZNaTL6eNIuG1IyA/edit")!
    var privacyPolicy = URL(string: "https://docs.google.com/document/d/1MRWyqS8OReXp9xsZfwc1rppwqKqYH054Yd7pCcCGdNk/edit#heading=h.20y6fa5gdawh")!
    var coffeURL = URL(string: "https://www.buymeacoin.com")!
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            Color.theme.main2
                .ignoresSafeArea()
            VStack(spacing: 16) {
                VStack {
                    userProfile
                        .frame(height: 160)
                    medalView
                    
                        .padding(.horizontal, 16)
                    
                        .cornerRadius(20)
                }
                .padding(.horizontal, 16)
                .background(.regularMaterial)
                .environment(\.colorScheme, .light)
                .cornerRadius(25)
                
                VStack {
                    linksView
                }
                Spacer()
            }
            .padding(.horizontal, 32)
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.black)
                }
                
            }
        }
        .font(.labGrotesque(.regular, size: 16))
        .navigationTitle("Зал славы")
        .navigationBarBackButtonHidden()
        .navigationBarTitleDisplayMode(.inline)
        
    }
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            HonorView()
        }
    }
}

extension HonorView {
    
    private var userProfile: some View {
        HStack(spacing: 24) {
            Image(vm.userProfile.userImage)
                .resizable()
                .scaledToFill()
                .frame(width: 100, height: 100)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .background {
                    RoundedRectangle(cornerRadius: 25)
                        .foregroundColor(Color.theme.orange.opacity(0.5))
                        .frame(width: 111, height: 111)
                }
                .shadow(color: Color("Color1").opacity(0.9), radius: 5, y: 3)
            VStack(alignment: .leading) {
                Text("Ваше имя:")
                TextField("введите ваше имя...", text: $vm.userProfile.userName)
                    .font(.labGrotesque(.regular, size: 20))
            }
            .font(.labGrotesque(.thin, size: 14))
        }
        
    }
    
    private var medalView: some View {
        VStack(alignment: .leading, spacing: 32) {
            
            HStack(spacing: 16) {
                Text("Медитировали")
                    .font(.labGrotesque(.regular, size: 20))
                Spacer()
                Text("\((Int(vm.userProfile.userTotalTime/60)).formatted()) мин")
                    .font(.labGrotesque(.regular, size: 20))
            }
            
            HStack(spacing: 16) {
                Text("Практиковали")
                    .font(.labGrotesque(.regular, size: 20))
                Spacer()
                VStack(spacing: 20) {
                    Text("\(vm.userProfile.userTotalDays) дня")
                        .font(.labGrotesque(.regular, size: 20))
                }
            }
            
            
            HStack(spacing: 16) {
                Text("Лучший результат")
                    .font(.labGrotesque(.regular, size: 20))
                Spacer()
                VStack(spacing: 20) {
                    Text("\(vm.userProfile.userBestStreak) дня")
                        .font(.labGrotesque(.regular, size: 20))
                }
                .cornerRadius(0)
            }
            
        }
        .padding(.bottom, 24)
        
    }
    
    private var linksView: some View {
        VStack(spacing: 10) {
//            Link("Buy me a coffe☕️", destination: coffeURL)
            Link("Terms of service", destination: termsOfService)
            Link("Privacy policy", destination: privacyPolicy)
        }
        .foregroundColor(.black)
    }
}
