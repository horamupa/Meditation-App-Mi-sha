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
    @EnvironmentObject var audioManager: AudioManager
    @State var isSettings: Bool = false
    @State var currentIndex: Int = 0
    @State var isActualLesson: Bool = false
    
    
    var body: some View {
        ZStack {
            Color.theme.white
                .ignoresSafeArea()
            VStack(alignment: .leading, spacing: 15) {
                Spacer()
               upperBlock
                
                Text("Свежая серия:")
                    .font(.labGrotesque(.regular, size: 18))
               middleBlock
                    .cornerRadius(25)
                    .shadow(radius: 2, y: 2)
                    .onTapGesture {
                        isActualLesson = true
                    }
                Spacer()
                
               Text("В нашем сериале:")
                    .font(.labGrotesque(.regular, size: 20))
                   
               bottomBlock
                    .shadow(radius: 2, y: 2)
                Spacer()
            }
            .padding(30)
            .foregroundColor(Color.theme.black)
            .navigationBarHidden(true)
        }
        .sheet(isPresented: $isSettings, content: {
            SettingsView()
        })
        .sheet(isPresented: $isActualLesson) {
            if let lesson = vm.actualLesson() {
                
                PlayerView(model: lesson)
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
            HStack {
                VStack(alignment: .leading) {
                    Text("Good")
                    Text("Morning")
                }
                .foregroundColor(Color.theme.black)
                .font(.meditation(.bold, size: 40))
                
                
                Spacer()
                NavigationLink {
                    SettingsView()
                } label: {
                    Image(systemName: "text.justify.left")
                        .font(.system(size: 30, weight: .bold))
                        .frame(width: 50, height: 80, alignment: .topTrailing)
                }
            }
    }
    
    var middleBlock: some View {
        
        HomeNextCourseView(model: vm.actualLesson() ?? TrackModel.track)
/*
         Image("home1")
             .resizable()
             .frame(height: 250)
             .foregroundColor(Color.theme.orange)
 
             .overlay(alignment: .bottomTrailing) {
                 HStack {
                     Text("Start your journey here")
                         .font(.labGrotesque(.medium, size: 16))
                         Spacer()
                     Image(systemName: "play.circle")
                         .scaleEffect(2.5)
                         .foregroundColor(Color.theme.white)
                         .frame(width: 50, height: 50)
                 }
                 .padding(5)
                 .padding(.horizontal, 20)
                 .frame(maxWidth: .infinity)
                 .background(.ultraThinMaterial)
 
             }
             .cornerRadius(25)
             .onTapGesture {
                 isActualLesson = true
             }
 */

    }
    
    var bottomBlock: some View {
        ScrollView(.horizontal) {
            HStack(spacing: 20) {
                if !vm.courses.isEmpty {
                    ForEach(vm.courses) { item in
                        NavigationLink(destination: CourseView(innerCourse: item)) {
                            ZStack(alignment: .bottomTrailing) {

                                Image(item.image)
                                    .resizable()
                                    .scaledToFill()
                                
                                Text(item.name)
                                    .font(.labGrotesque(.regular, size: 16))
                                    .minimumScaleFactor(0.5)
                                    .padding(15)
                                    .frame(maxWidth: .infinity)
                                    .background(.ultraThinMaterial)
                                    
                            }
                            .frame(width: UIScreen.main.bounds.width / 2.5, height: 250)
                            .cornerRadius(15)
                        }
                    }
                } else {
                                        Rectangle()
                                            .frame(width: UIScreen.main.bounds.width / 2.5, height: 250)
                                            .foregroundColor(Color.theme.blue)
                                            .cornerRadius(25)
                    
//                                                Spacer()
                                        Rectangle()
                                            .frame(width: UIScreen.main.bounds.width / 2.5, height: 250)
                                            .foregroundColor(Color.theme.purple)
                                            .cornerRadius(25)
                }
            }
            .frame(maxWidth: .infinity)
        }
    }
        
        var halfScreen: CGFloat {
            UIScreen.main.bounds.width / 2
        }
        
}
