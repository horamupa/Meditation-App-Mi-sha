//
//  Settings.swift
//  Mi-sha
//
//  Created by MM on 12.12.2022.
//

import SwiftUI

struct SettingsView: View {
    
    @StateObject var vm = SettingsViewModel()
    
//    @State var userName = "UserName"
    
    
    var defaultURL = URL(string: "https://www.google.com")!
    var secondURL = URL(string: "https://www.youtube.com")!
    var coffeURL = URL(string: "https://www.buymeacoin.com")!
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
            ZStack {
                Color.theme.main2
                    .ignoresSafeArea()
                VStack(spacing: 10) {
                    VStack {
                        userProfile
                            .padding(20)
                            .frame(maxWidth: .infinity)
                            .background(.regularMaterial)
                            .cornerRadius(30)
                        medalView
    //                        .cornerRadius(0)
                            .padding(20)
                            .frame(maxWidth: .infinity)
                            .background(.regularMaterial)
                            
                            .cornerRadius(30)
//                            .padding(.horizontal, 20)
                    }
                    .padding()
                    
                    VStack {
                        linksView
                    }
                    
                    Spacer()
                }
                .padding(.horizontal, 10)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .foregroundColor(.black)
                    }

                }
            }
            .font(.labGrotesque(.regular, size: 16))
            .navigationTitle("Настройки")
            .navigationBarBackButtonHidden()
            .navigationBarTitleDisplayMode(.inline)

    }
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SettingsView()
        }
    }
}

extension SettingsView {
    
    private var userProfile: some View {
        HStack(spacing: 30) {
            Image(vm.userProfile.userImage)
                .resizable()
                .scaledToFill()
                .frame(width: 100, height: 100)
                .clipShape(Circle())
                .shadow(color: Color("Color1").opacity(0.9), radius: 5, y: 5)
            VStack(alignment: .leading) {
                Text("Ваше имя:")
                TextField("введите ваше имя...", text: $vm.userProfile.userName)
//                Text(vm.userProfile.userName)
                    .font(.labGrotesque(.regular, size: 20))
            }
            .font(.labGrotesque(.thin, size: 14))
        }
        
    }
    
    private var medalView: some View {
        VStack(spacing: 20) {
            HStack(spacing: 40) {
                VStack(spacing: 10) {
                    Text("Медитировали")
                        .font(.labGrotesque(.regular, size: 18))
                        
                    ZStack {

                        Image("flower5")
                            .resizable()
                            .scaledToFill()
                            .clipShape(Circle())
                        VStack(spacing: 5) {
                            
                            Text("\((Int(vm.userProfile.userTotalTime/60)).formatted()) мин")
                                .font(.labGrotesque(.regular, size: 24))
                        }
                    }
                    .frame(width: 110, height: 110)
                    .cornerRadius(0)
                    .background {
                        Circle()
                            .foregroundColor(Color.theme.orange.opacity(0.6))
                            .frame(width: 125, height: 125)
                    }
                }
                
                VStack(spacing: 10) {
                    Text("Практиковали")
                        .font(.labGrotesque(.regular, size: 18))
                    ZStack {
                            Image("flower4")
                                .resizable()
                                .scaledToFill()
                                .clipShape(Circle())
                                
                            VStack(spacing: 20) {
                                
                                Text("\(vm.userProfile.userTotalDays) дня")
                                    .font(.labGrotesque(.regular, size: 24))
                            }
                    }
                    .frame(width: 110, height: 110)
                    .cornerRadius(0)
                    .background {
                        Circle()
                            .foregroundColor(Color.theme.orange.opacity(0.6))
                            .frame(width: 125, height: 125)
                    }
                }
                
            }
            
            
            VStack(spacing: 10) {
                Text("Лучший результат")
                    .font(.labGrotesque(.regular, size: 18))
                ZStack {
                        Image("flower6")
                            .resizable()
                            .scaledToFill()
                            .clipShape(Circle())
                            
                        VStack(spacing: 20) {
                            
                            Text("\(vm.userProfile.userBestStreak) дня")
                                .font(.labGrotesque(.regular, size: 24))
                        }
                }
                .frame(width: 110, height: 110)
                .cornerRadius(0)
                .background {
                    Circle()
                        .foregroundColor(Color.theme.orange.opacity(0.6))
                        .frame(width: 125, height: 125)
                }
            }
            HStack {
                Text("Имя")
                Spacer()
                Text(vm.userProfile.userName)
                    
            }
            HStack {
                Text("Статус")
                Spacer()
                Text("Невероятный герой")
            }
        }
        .padding(.vertical, 15)
    }
    
    private var linksView: some View {
        VStack(spacing: 10) {
            Link("Buy me a coffe☕️", destination: coffeURL)
            Link("Terms of service", destination: defaultURL)
            Link("Privacy policy", destination: secondURL)
        }
        .foregroundColor(.black)
    }
}
