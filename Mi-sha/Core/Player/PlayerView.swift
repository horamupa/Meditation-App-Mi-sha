//
//  PlayerVie.swift
//  Mi-sha
//
//  Created by MM on 08.12.2022.
//

import SwiftUI
import Combine
import Firebase
import FirebaseStorage
import AVKit

struct PlayerView: View {
    @EnvironmentObject var audioManager: AudioManager
    var model: TrackModel
    
    @State private var value: Double = 0.0
    @State var isPause: Bool = false
    @State private var isEditing: Bool = false
    @Environment(\.dismiss) var dismiss
    @State var player = AVPlayer()
    
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
                        AudioManager.shared.stop()
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
                if let player = AudioManager.shared.player {
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
                                AudioManager.shared.player?.currentTime -= 10
                            }
                            Spacer()
                            PlayerControlButton(systemName: isPause ? "pause.circle.fill" : "play.circle.fill", fontSize: 44) {
                                isPause.toggle()
                                AudioManager.shared.playPause()
                            }
                            Spacer()
                            PlayerControlButton(systemName: "goforward.10") {
                                AudioManager.shared.player?.currentTime += 10
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
//            audioManager.startPlayer(name: model.id)
           let storage = Storage.storage().reference(forURL: model.url)
            storage.downloadURL { url, error in
                if let error = error {
                    print("Error download from the firebase. \(error.localizedDescription)")
                } else {
//                    self.player = AVPlayer(url: url!)
//                    player.play()
                    AudioManager.shared.startPlayerStream(url: model.url)
                    print("player Succes")
                    
                }
            }
        }
        .onReceive(timer) { _ in
            guard
                let player = AudioManager.shared.player, !isEditing
            else {
                print("no audioplayer in manager")
                return }
            value = player.currentTime
        }
        .onDisappear {
            ProgressInfo.shared.updateProgress(model: model)
            ProgressInfo.shared.savePreference()
            print(ProgressInfo.shared.progressInfo)
        }
    }
}

struct PlayerVie_Previews: PreviewProvider {
    static var previews: some View {
        PlayerView(model: dev.track)
            .environmentObject(dev.vm)
            .environmentObject(AudioManager.shared)
    }
}
