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
import AppTrackingTransparency

struct HomeView: View {
    
    @EnvironmentObject var vm: HomeViewModel
    var audioManager = AVManager.shared
    @ObservedObject var progress = UserProgress.shared
    @State var isSettings: Bool = false
    @State var currentIndex: Int = 0
    var chapterCell: [GridItem] = [GridItem(.flexible(), spacing: 16, alignment: .bottom)]
    
    var body: some View {
        ZStack {
            Color.theme.white
                .ignoresSafeArea()
            
            VStack(alignment: .leading, spacing: 16) {
                upperBlock
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Новая история:")
                        .font(.labGrotesque(.regular, size: 20))
                    
                    middleBlock
                        .shadow(radius: 4, y: 4)
                }
                
                Spacer()
                VStack(alignment: .leading, spacing: 8) {
                    Text("Содержание:")
                        .font(.labGrotesque(.regular, size: 20))
                    bottomBlock
                        .shadow(radius: 4, y: 4)
                }
            }
            .padding(16)
            .foregroundColor(Color.theme.black)
            .navigationBarHidden(true)
        }
        .sheet(isPresented: $isSettings, content: {
            HonorView()
        })
        .onAppear {
            ATTrackingManager.requestTrackingAuthorization { status in
                switch status {
                    case .authorized:
                        print("enable tracking")
                    case .denied:
                        print("disable tracking")
                    default:
                        print("disable tracking")
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            HomeView()
                .environmentObject(dev.vm)
                .environmentObject(AVManager.shared)
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
                HonorView()
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
        }
    }
    
    var bottomBlock: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 16) {
                if !vm.courses.isEmpty {
                    
                    ForEach(vm.courses) { item in
                        NavigationLink(destination: ChapterView(innerCourse: item)) {
                            
                            ZStack(alignment: .bottom) {
                                Color("\(item.color)")
                                
                                Image(item.image)
                                    .resizable()
                                    .scaledToFill()
                                    .offset(y: -50)
                                
                                Text(item.name)
                                    .font(.labGrotesque(.regular, size: 18))
                                    .frame(height: 50)
                                    .frame(maxWidth: .infinity)
                                    .background(.regularMaterial.opacity(0.9))
                                    .environment(\.colorScheme, .light)
                            }
                            .cornerRadius(15)
                        }
                    }
                }
            }
        }
    }
    
    var halfScreen: CGFloat {
        UIScreen.main.bounds.width / 2
    }
}
