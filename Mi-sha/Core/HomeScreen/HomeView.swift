//
//  ContentView.swift
//  Mi-sha
//
//  Created by MM on 08.12.2022.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var vm: AudioViewModel
    @EnvironmentObject var audioManager: AudioManager
    @State var isSettings: Bool = false
    @State var currentIndex: Int = 0
    
    
    var body: some View {
        ZStack {
            Color.theme.black
                .ignoresSafeArea()
            VStack {
                //                LazyHStack {
                //                    ForEach(vm.meditationList) { item in
                //                        NavigationLink {
                //                            AudioView(model: item)
                //                                .environmentObject(audioManager)
                //                        } label: {
                //                            CardView(model: item)
                //                        }
                //                    }
                //                }
                Text("Best Meditation ever")
                    .foregroundColor(.red)
                    .font(.title)
                carouselView(spacing: 30, index: $currentIndex, items: vm.meditationList) { meditation in
                    GeometryReader { proxy in
                        let size = proxy.size
                        
                        Image(meditation.image ?? "stones")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: size.width)
                            .cornerRadius(10)
                    }
                }
                .padding(.vertical, 80)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        isSettings.toggle()
                    } label: {
                        Image(systemName: "text.justifyleft")
                            .foregroundColor(.white)
                    }
                }
            }
        }
       
        .sheet(isPresented: $isSettings, content: {
            SettingsView()
            
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(dev.vm)
            .environmentObject(AudioManager())
    }
}

extension HomeView {
        
        var halfScreen: CGFloat {
            UIScreen.main.bounds.width / 2
        }
        
}
