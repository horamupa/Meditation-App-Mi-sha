//
//  PlayerVie.swift
//  Mi-sha
//
//  Created by MM on 08.12.2022.
//

import SwiftUI
import Combine

struct PlayerView: View {
    @EnvironmentObject var audioManager: AudioManager
    var model: AudioModel
    
    @State private var value: Double = 0.0
    @State var isPause: Bool = false
    @State private var isEditing: Bool = false
    @Environment(\.dismiss) var dismiss
    
    let timer = Timer
        .publish(every: 0.5, on: .main, in: .common)
        .autoconnect()
    
    var body: some View {
        ZStack {
            
            Image("stones")
                .resizable()
                .scaledToFill()
                .frame(maxWidth: UIScreen.main.bounds.width)
                .ignoresSafeArea()
            Rectangle()
                .background(.thinMaterial)
                .opacity(0.25)
                .ignoresSafeArea()
            
            VStack(alignment: .leading, spacing: 32) {
                Image(systemName: "xmark.circle.fill")
                    .font(.title)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .onTapGesture {
                        audioManager.stop()
                        dismiss()
                    }
                Text(model.name)
                    .font(.title)
                    .fontWeight(.bold)
                    .blur(radius: 0.1)
                    .foregroundColor(.white)
                    .lineLimit(1)
                    .minimumScaleFactor(0.5)
                Spacer()
                if let player = audioManager.player {
                    VStack(spacing: 5) {
                        Slider(value: $value, in: 0...player.duration) { editing in
                            //return rewind slider to audio
                            isEditing = editing
                            if !editing {
                                player.currentTime = value
                            }
                        }
                        .accentColor(.white)
                        HStack {
                            Text(DateComponentsFormatter.positional.string(from: player.currentTime) ?? "0:00")
                            Spacer()
                            Text(DateComponentsFormatter.positional.string(from: player.duration) ?? "0:00")
                        }
                        .font(.caption)
                        HStack {
                            Spacer()
                            PlayerControlButton(systemName: "gobackward.10") {
                                player.currentTime -= 10
                            }
                            Spacer()
                            PlayerControlButton(systemName: isPause ? "pause.circle.fill" : "play.circle.fill", fontSize: 44) {
                                isPause.toggle()
                                audioManager.playPause()
                            }
                            Spacer()
                            PlayerControlButton(systemName: "goforward.10") {
                                player.currentTime += 10
                            }
                            Spacer()
                        }
                    }
                    .foregroundColor(.white)
                }
            }
            .padding(.horizontal, 20)
        }
        .onAppear {
            audioManager.startPlayer(name: model.id)
        }
        .onReceive(timer) { _ in
            guard
                let player = audioManager.player, !isEditing
            else {
                print("no audioplayer in manager")
                return }
            value = player.currentTime
        }
    }
}

struct PlayerVie_Previews: PreviewProvider {
    static var previews: some View {
        PlayerView(model: dev.model)
            .environmentObject(dev.vm)
            .environmentObject(AudioManager())
    }
}
