//
//  ContentView.swift
//  Mi-sha
//
//  Created by MM on 08.12.2022.
//
/*
 Want to do:
 Upgrade first screen main window to next meditation
 */

import SwiftUI
import Firebase

struct HomeView: View {
    
    @EnvironmentObject var vm: HomeViewModel
    var audioManager = AudioManager.shared
    @ObservedObject var progress = UserProgress.shared
    @State var isSettings: Bool = false
    @State var currentIndex: Int = 0
    
    var body: some View {
        ZStack {
            Color.theme.white
                .ignoresSafeArea()
            VStack(alignment: .leading, spacing: 20) {
                Spacer()
                
                upperBlock
                
                Text("Свежая история:")
                    .font(.labGrotesque(.regular, size: 20))
                
                middleBlock
                
                Spacer()
                
               Text("В нашем сериале:")
                    .font(.labGrotesque(.regular, size: 20))
               bottomBlock

                
                Spacer()
            }
            .padding(30)
            .foregroundColor(Color.theme.black)
            .navigationBarHidden(true)
        }
        .sheet(isPresented: $isSettings, content: {
            SettingsView()
        })
        .onAppear {
            if let url2 = vm.actualLesson()?.url {
                audioManager.preDownload(url: url2)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            HomeView()
                .environmentObject(dev.vm)
                .environmentObject(AudioManager.shared)
        }
    }
}

extension HomeView {
    
    var upperBlock: some View {
        HStack(alignment: .top) {
                VStack(alignment: .leading) {
                    Text("Good")
                    Text("Morning")
                }
                .foregroundColor(Color.theme.black)
                .font(.labGrotesque(.bold, size: 40))
                
            
                Spacer()
                NavigationLink {
                    SettingsView()
                } label: {
                    ZStack(alignment: .bottomLeading) {
                        Circle()
                            .frame(width: 50, height: 50)
                            .foregroundColor(Color(#colorLiteral(red: 0.9607843137, green: 0.6274509804, blue: 0.4196078431, alpha: 1)))
                        Circle()
                            .frame(width: 30, height: 30)
                            .foregroundColor(Color(#colorLiteral(red: 1, green: 0.7725490196, blue: 0.2666666667, alpha: 1)))
                            .blur(radius: 1)
                    }
//                    Image(systemName: "text.justify.left")
//                        .font(.system(size: 30, weight: .bold))
//                        .frame(width: 50, height: 80, alignment: .topTrailing)
                }
            }
    }
    
    var middleBlock: some View {
        NavigationLink {
            if let lesson = vm.actualLesson() {
                PlayerView(model: lesson)
            }
        } label: {
            HomeNextCourseView(model: vm.actualLesson() ?? TrackModel.track)
                .cornerRadius(15)
                .shadow(radius: 2, y: 2)
        }
    }
    
    var bottomBlock: some View {
        ScrollView(.horizontal) {
            HStack(spacing: 20) {
                if !vm.courses.isEmpty {
                    ForEach(vm.courses) { item in
                        NavigationLink(destination: ChapterView(innerCourse: item)) {
                            ZStack(alignment: .bottom) {
                                Image(item.image)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: UIScreen.main.bounds.width / 2.5, height: 250)
                                Text(item.name)
                                    .font(.labGrotesque(.regular, size: 16))
//                                    .minimumScaleFactor(0.5)
                                    .padding(15)
                                    .frame(maxWidth: .infinity)
                                    .background(.regularMaterial.opacity(0.9))
                            }
                            
                            .cornerRadius(15)
                        }
                    }
                } else {
                    ZStack(alignment: .bottom) {
                        Image("home3")
                            .resizable()
                            .scaledToFill()
                        
                        Text("Сезон первый")
                            .font(.labGrotesque(.regular, size: 16))
//                            .minimumScaleFactor(0.5)
                            .padding(15)
                            .frame(maxWidth: .infinity)
                            .background(.regularMaterial.opacity(0.9))
                            
                    }
                  
                    .cornerRadius(15)
                    
                    ZStack(alignment: .bottom) {

                        Image("Doggo2")
                            .resizable()
                            .scaledToFill()
                            .frame(width: UIScreen.main.bounds.width / 2.5)
                        Text("Второй сезон")
                            .font(.labGrotesque(.regular, size: 16))
                            .padding(15)
                            .frame(maxWidth: .infinity)
                            .background(.regularMaterial.opacity(0.9))
                            
                    }
                  
                    .cornerRadius(15)
                }
            }
//            .frame(maxWidth: .infinity)
        }
        .shadow(radius: 2, y: 2)
    }
        
        var halfScreen: CGFloat {
            UIScreen.main.bounds.width / 2
        }
        
}
