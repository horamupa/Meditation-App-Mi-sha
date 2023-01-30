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
    
    init(model: TrackModel) {
        self.model = model
        _vm = StateObject(wrappedValue: PlayerViewModel(model: model))
    }
    
    @StateObject var vm: PlayerViewModel
    @State var isPause: Bool = false
    @State private var isEditing: Bool = false
    @Environment(\.dismiss) var dismiss
    var model: TrackModel
//    var manager: DataManager
//    var audioManager = AudioManager.shared
    let closeRangeCreate: ClosedRange<Double> = 0...60
    
    
    var body: some View {
        ZStack {
            Color.theme.main2
                .ignoresSafeArea()
            Image("home1")
                .resizable()
                .scaledToFit()
            
            VStack(spacing: 32) {
                dissmissButton
                    .padding()
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
        .navigationTitle("")
        .navigationBarHidden(true)
//        .navigationBarBackButtonHidden()
        .onAppear {
            vm.startOnAppear()
        }
        .onDisappear {
            vm.checkProgress()
        }
        .onReceive(vm.timer) { _ in
            guard
                let player = vm.audioManager.player, !isEditing
            else {
                print("no audioplayer in manager")
                return }
            vm.playerTime = player.currentTime
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
                vm.audioManager.stop()
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
                vm.audioManager.player?.currentTime -= 10
            }
            .scaleEffect(1.3)
            Spacer()
            PlayerControlButton(systemName: !isPause ? "pause.circle.fill" : "play.circle.fill", fontSize: 44) {
                isPause.toggle()
                vm.audioManager.playPause()
            }
            .scaleEffect(1.3)
            Spacer()
            PlayerControlButton(systemName: "goforward.10") {
                vm.audioManager.player?.currentTime += 10
            }
            .scaleEffect(1.3)
            Spacer()
        }
    }
    
    var playerControl: some View {
        VStack(spacing: 20) {
            playerSlider
            playerButtons
        }
        .padding(.bottom, 10)
        .foregroundColor(Color.theme.black)
        .overlay {
            if vm.audioManager.isDownloaded {
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
    
    var playerSlider: some View {
        Group {
            Slider(value: $vm.playerTime, in: 0...(vm.audioManager.player?.duration ?? 0) ) { editing in
                //return rewind slider to audio
                isEditing = editing
                if !editing {
                    vm.audioManager.player?.currentTime = vm.playerTime
                }
            }
            .accentColor(.white)
            HStack {
                Text(DateComponentsFormatter.positional.string(from: vm.audioManager.player?.currentTime ?? 0) ?? "0:00")
                Spacer()
                Text(DateComponentsFormatter.positional.string(from: vm.audioManager.player?.duration ?? 0) ?? "0:00")
            }
        }
        .font(.caption)
    }
}
