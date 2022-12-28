//
//  Settings.swift
//  Mi-sha
//
//  Created by MM on 12.12.2022.
//

import SwiftUI

struct SettingsView: View {
    
    @StateObject var vm = SettingsViewModel()
    
    @State var userName = "UserName"
    
    
    var defaultURL = URL(string: "https://www.google.com")!
    var secondURL = URL(string: "https://www.youtube.com")!
    var coffeURL = URL(string: "https://www.buymeacoin.com")!
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.theme.white
                    .ignoresSafeArea()
                VStack {
                    HStack {
                        Image(vm.userProfile.userImage)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 100, height: 100)
                            .clipShape(Circle())
                        VStack(alignment: .leading) {
                            Text(vm.userProfile.userName)
                                .font(.labGrotesque(.regular, size: 16))
                        }
                    }
                    
                    VStack(spacing: 20) {
                        Text("Ваши достижения:")
                            .font(.labGrotesque(.medium, size: 20))
                        
                        HStack {
                            ZStack {
                                RoundedRectangle(cornerRadius: 15)
                                    .foregroundColor(Color.theme.main)
                                    .shadow(radius: 5, y: 5)
                                VStack(spacing: 5) {
                                    Text("Вы медитировали:")
                                    Text("\(vm.userProfile.userTotalTime.formatted()) мин")
                                }
                            }
                            ZStack {
                                RoundedRectangle(cornerRadius: 15)
                                    .foregroundColor(Color.theme.main)
                                    .shadow(radius: 5, y: 5)
                                VStack(spacing: 5) {
                                    Text("Дней практики")
                                    Text("\(vm.userProfile.userTotalDays) дней")
                                }
                            }
                        }
                        
                        
                        VStack(spacing: 5) {
                            Text("Дней без пропусков")
                            ZStack {
                                Circle()
                                    .frame(width: 90, height: 90)
                                    .foregroundColor(Color.theme.main)
                                    .shadow(radius: 5, y: 5)
                                VStack {
                                    Text("\(vm.userProfile.userBestStreak) дня")
                                }
                            }
                        }
                    }
                    .padding()
//                    .background(.thinMaterial)
//                    .padding(.top, 20)
                    List {
                        Section("User Info") {
                            HStack {
                                Text("Имя")
                                Spacer()
                                Text(vm.userProfile.userName)
                                    
                            }
                            HStack {
                                Text("Статус")
                                Spacer()
                                Text("Unbelievable hero")
                            }
                        }
                        Section("Common Links") {
                            Link("Terms of service", destination: defaultURL)
                            Link("Privacy policy", destination: secondURL)
                        }
                        Section("Buy me a coffe") {
                            Link("Buy me a coffe☕️", destination: coffeURL)
                        }
                    }
    //                .navigationTitle("Settings")
                    .navigationBarBackButtonHidden()
    //                .statusBarHidden()
    //                .labelsHidden()
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
                .listStyle(.grouped )
                }
            }
            .font(.labGrotesque(.regular, size: 16))
        }
    }
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
//        NavigationView {
            SettingsView()
//        }
        
    }
}
