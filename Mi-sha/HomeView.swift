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
    
    var body: some View {
        ZStack {
            Color.theme.black
            VStack {
                HStack {
                    ForEach(vm.meditationList) { item in
                        NavigationLink {
                            AudioView(model: item)
                                .environmentObject(audioManager)
                        } label: {
                            CardView(model: item)
                        }
                    }
                }
            }
            .padding()
        }
        .ignoresSafeArea()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(dev.vm)
            .environmentObject(AudioManager())
    }
}
