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
    
    
    var defaultURL = URL(string: "https://www.google.com")!
    var secondURL = URL(string: "https://www.youtube.com")!
    var coffeURL = URL(string: "https://www.buymeacoin.com")!
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
            ZStack {
                Color.theme.main2
                    .ignoresSafeArea()
                VStack(spacing: 16) {
                    VStack {
                        userProfile
                            .padding(.horizontal, 16)
                            .padding(.vertical, 16)
                            .frame(maxWidth: .infinity)

                            .cornerRadius(10)
                        medalView
    //                        .cornerRadius(0)
                            .padding(.horizontal, 16)
                            .frame(maxWidth: .infinity)
                            .cornerRadius(10)
//                            .padding(.horizontal, 20)
                    }
                    .background(.regularMaterial)
                    .cornerRadius(10)
//                    .padding()
                    
                    VStack {
                        linksView
                    }
                }
                .padding(.horizontal, 16)
                .padding(.top, 10)
            }
//            .toolbar {
//                ToolbarItem(placement: .navigationBarLeading) {
//                    Button {
//                        dismiss()
//                    } label: {
//                        Image(systemName: "xmark")
//                            .foregroundColor(.black)
//                    }
//
//                }
//            }
            .font(.labGrotesque(.regular, size: 16))
            .navigationTitle("Зал славы")
//            .navigationBarBackButtonHidden()
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
                .clipShape(RoundedRectangle(cornerRadius: 10))
            
                .background {
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(Color.theme.orange)
                        .frame(width: 111, height: 111)
                }
                .shadow(color: Color("Color1").opacity(0.9), radius: 5, y: 3)
            VStack(alignment: .leading) {
                Text("Ваше имя:")
                TextField("введите ваше имя...", text: $vm.userProfile.userName)
//                Text(vm.userProfile.userName)
                    .font(.labGrotesque(.regular, size: 20))
            }
            .font(.labGrotesque(.thin, size: 14))
        }
        .padding(.top, 20)
        
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
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                        VStack(spacing: 5) {
                            
                            Text("\((Int(vm.userProfile.userTotalTime/60)).formatted()) мин")
                                .font(.labGrotesque(.regular, size: 24))
                        }
                    }
                    .frame(width: 100, height: 100)
                    .cornerRadius(0)
                    .background {
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(Color.theme.orange)
                            .frame(width: 112, height: 112)
                    }
                    .shadow(color: Color("Color1").opacity(0.9), radius: 5, y: 3)
                }
                
                VStack(spacing: 10) {
                    Text("Практиковали")
                        .font(.labGrotesque(.regular, size: 18))
                    ZStack {
                            Image("flower4")
                                .resizable()
                                .scaledToFill()
//                        #error
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                
                            VStack(spacing: 20) {
                                
                                Text("\(vm.userProfile.userTotalDays) дня")
                                    .font(.labGrotesque(.regular, size: 24))
                            }
                    }
                    .frame(width: 100, height: 100)
                    .cornerRadius(0)
                    .background {
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(Color.theme.orange)
                            .frame(width: 112, height: 112)
                    }
                    .shadow(color: Color("Color1").opacity(0.9), radius: 5, y: 3)
                }
                
            }
            
            
            VStack(spacing: 10) {
                Text("Лучший результат")
                    .font(.labGrotesque(.regular, size: 18))
                ZStack {
                        Image("flower6")
                            .resizable()
                            .scaledToFill()
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            
                        VStack(spacing: 20) {
                            
                            Text("\(vm.userProfile.userBestStreak) дня")
                                .font(.labGrotesque(.regular, size: 24))
                        }
                }
                .frame(width: 100, height: 100)
                .cornerRadius(0)
                .background {
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(Color.theme.orange)
                        .frame(width: 112, height: 112)
                }
                .shadow(color: Color("Color1").opacity(0.9), radius: 5, y: 3)
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
