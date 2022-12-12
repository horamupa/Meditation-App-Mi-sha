//
//  PlayerVie.swift
//  Mi-sha
//
//  Created by MM on 08.12.2022.
//

import SwiftUI

struct PlayerView: View {
    var model: AudioModel
    
    @State private var value: Double = 0.0
    @State var isPause: Bool = false
    @Environment(\.dismiss) var dismiss
    
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
                VStack(spacing: 5) {
                    Slider(value: $value, in: 0...60)
                        .accentColor(.white)
                    HStack {
                        Text("0:00")
                        Spacer()
                        Text("1:00")
                    }
                    .font(.caption)
                    HStack {
                        Spacer()
                        PlayerControlButton(systemName: "gobackward.10") {
                            
                        }
                        Spacer()
                        PlayerControlButton(systemName: isPause ? "pause.circle.fill" : "play.circle.fill", fontSize: 44) {
                            isPause.toggle()
                        }
                        Spacer()
                        PlayerControlButton(systemName: "goforward.10") {
                            
                        }
                        Spacer()
                    }
                }
                .foregroundColor(.white)
            }
            .padding(.horizontal, 20)
        }
        .onAppear {
            AudioManager.share.startPlayer(name: model.id)
        }
    }
}

struct PlayerVie_Previews: PreviewProvider {
    static var previews: some View {
        PlayerView(model: dev.model)
            .environmentObject(dev.vm)
    }
}
