//
//  MeditationView.swift
//  Mi-sha
//
//  Created by MM on 08.12.2022.
//

import SwiftUI

struct AudioView: View {
    
    @EnvironmentObject var vm: AudioViewModel
    @EnvironmentObject var audioManager: AudioManager
    @State var isPlayerShow: Bool = false
    var model: AudioModel
    
    var body: some View {
        VStack(spacing: 0) {
            Image("stones")
                .resizable()
                .scaledToFill()
                .frame(height: UIScreen.main.bounds.height / 3)
            ZStack(alignment: .leading) {
                Color(red: 24/255, green: 23/255, blue: 22/255)
                VStack(alignment: .leading, spacing: 8) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Music")
                        Text(DateComponentsFormatter.abbreviated.string(from: model.duration) ?? model.duration.formatted() + "s")
                    }
                    .font(.subheadline)
                    .textCase(.uppercase)
                    .opacity(0.7)
                    Text(model.name)
                        .font(.title)
                    Button {
                        isPlayerShow.toggle()
                    } label: {
                        Label("Play", systemImage: "play.fill")
                            .font(.headline)
                            .foregroundColor(Color.theme.black)
                            .padding(.vertical, 10)
                            .frame(maxWidth: .infinity)
                            .background(Color.white)
                            .cornerRadius(20)
                    }
                    Text(model.description)
                    Spacer()
                }
                .padding()
            }
            .foregroundColor(.white)
        }
        .ignoresSafeArea()
        .fullScreenCover(isPresented: $isPlayerShow) {
            PlayerView(model: model)
                .environmentObject(audioManager)
        }
    }
}

struct MeditationView_Previews: PreviewProvider {
    static var previews: some View {
        AudioView(model: dev.model)
            .environmentObject(AudioManager() )
    }
}
