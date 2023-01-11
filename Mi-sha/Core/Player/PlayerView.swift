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
    var audioManager = AudioManager.shared
    var model: TrackModel
    
    @State private var value: Double = 0.0
    @State var isPause: Bool = false
    @State private var isEditing: Bool = false
    @Environment(\.dismiss) var dismiss
//    @State var player = AVPlayer()
    var manager = DataManager.shared
    let closeRangeCreate: ClosedRange<Double> = 0...60
    
    let timer = Timer
        .publish(every: 0.5, on: .main, in: .common)
        .autoconnect()
    
    var body: some View {
        ZStack {
            Color.theme.main2
                .ignoresSafeArea()
            Image("home1")
                .resizable()
                .scaledToFit()
            
            VStack(spacing: 32) {
                dissmissButton
                Spacer()
                LogoView()
                    .scaleEffect(0.5)
                    .offset(x: 100, y: -55)
                    .opacity(0.8)
                Spacer()
                Spacer()
                Spacer()
                trackName
                Spacer()
                playerControl
                    .padding(.horizontal, 10)
            }
            .padding(.horizontal, 20)
        }
        .statusBarHidden()
        .labelsHidden()
        .navigationBarBackButtonHidden()
//        .onAppear {
//           let storage = Storage.storage().reference(forURL: model.url)
//            storage.downloadURL { url, error in
//                if let error = error {
//                    print("Error download from the firebase. \(error.localizedDescription)")
//                    AudioManager.shared.startPlayer(name: "1")
//                } else {
//
//                    AudioManager.shared.startPlayerStream(url: model.url)
//                    print("player Succes")
//
//                }
//            }
//        }
        .onReceive(timer) { _ in
            guard
                let player = audioManager.player, !isEditing
            else {
                print("no audioplayer in manager")
                return }
            value = player.currentTime
        }
        .onDisappear {
            if audioManager.getPlayerTime() > 420 {
                ProgressInfo.shared.updateProgress(model: model)
                ProgressInfo.shared.savePreference()
                manager.userProfile.userTotalTime += audioManager.getPlayerTime()
                manager.userProfile.userTotalDays += 1
            }
        }
    }
}

struct PlayerView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerView(model: dev.track)
            .environmentObject(dev.vm)
    }
}

extension PlayerView {
    var dissmissButton: some View {
        Image(systemName: "xmark.circle.fill")
            .font(.title)
            .foregroundColor(.white)
            .frame(maxWidth: .infinity, alignment: .leading)
            .onTapGesture {
                AudioManager.shared.stop()
                dismiss()
            }
    }
    
    var trackName: some View {
    Text(model.name)
        .font(.labGrotesque(.medium, size: 30))
        .foregroundColor(Color.theme.black.opacity(0.7))
        .lineLimit(1)
        .minimumScaleFactor(0.5)
        .overlay(alignment: .bottom) {
            Capsule(style: .continuous)
                .frame(height: 3)
                .offset(y: 5)
                .foregroundColor(Color.theme.black.opacity(0.7))
        }
    }
    
    var playerButtons: some View {
        HStack {
            Spacer()
            PlayerControlButton(systemName: "gobackward.10") {
                audioManager.player?.currentTime -= 10
            }
            .scaleEffect(1.3)
            Spacer()
            PlayerControlButton(systemName: !isPause ? "pause.circle.fill" : "play.circle.fill", fontSize: 44) {
                isPause.toggle()
                audioManager.playPause()
            }
            .scaleEffect(1.3)
            Spacer()
            PlayerControlButton(systemName: "goforward.10") {
                audioManager.player?.currentTime += 10
            }
            .scaleEffect(1.3)
            Spacer()
        }
    }
    
    var playerControl: some View {
        VStack(spacing: 20) {
            Slider(value: $value, in: 0...(audioManager.player?.duration ?? 0) ) { editing in
                //return rewind slider to audio
                isEditing = editing
                if !editing {
                    audioManager.player?.currentTime = value
                }
            }
            .accentColor(.white)
            HStack {
                Text(DateComponentsFormatter.positional.string(from: audioManager.player?.currentTime ?? 0) ?? "0:00")
                Spacer()
                Text(DateComponentsFormatter.positional.string(from: audioManager.player?.duration ?? 0) ?? "0:00")
            }
            .font(.caption)
            playerButtons
            
        }
        .padding(.bottom, 10)
        .foregroundColor(Color.theme.black)
        .overlay {
            if audioManager.isDownloaded {
               EmptyView()
            } else {
                VStack {
                    Text("Почти загрузили...")
                        .font(.labGrotesque(.regular,size: 16))
                    ZStack {
                        ProgressView()
                            .scaleEffect(2)
                    }
                }
            }
        }
    }
}
