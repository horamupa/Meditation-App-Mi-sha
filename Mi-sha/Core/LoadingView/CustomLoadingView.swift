//
//  CustomLoadindView.swift
//  Mi-sha
//
//  Created by MM on 26.12.2022.
//

import SwiftUI

struct CustomLoadingView: View {
    var body: some View {
        ZStack {
            RadialGradient(
                gradient: Gradient(colors: [Color(#colorLiteral(red: 1, green: 0.8323456645, blue: 0.4732058644, alpha: 1)), Color(#colorLiteral(red: 1, green: 0.4932718873, blue: 0.4739984274, alpha: 1))]),
                center: .topLeading, startRadius: 200, endRadius: 600)
            .ignoresSafeArea()
            VStack(spacing: 40) {
                Spacer()
                ZStack(alignment: .bottomLeading) {
                    Circle()
                        .frame(width: 150, height: 150)
                        .foregroundColor(Color(#colorLiteral(red: 0.9559542537, green: 0.5613597035, blue: 0.4460546374, alpha: 1)))
                    Circle()
                        .frame(width: 100, height: 100)
                        .foregroundColor(Color(#colorLiteral(red: 1, green: 0.8323456645, blue: 0.4732058644, alpha: 1)))
                }
                .background {
                    Circle()
                        .frame(width: 200, height: 200)
                        .foregroundColor(.white.opacity(0.2))
                        .blur(radius: 10)
                        
                }
                Text("Медитации Мёд")
                    .font(.largeTitle)
                    .fontWeight(.medium)
                    .foregroundColor(.black.opacity(0.7))
                    .overlay(alignment: .bottom) {
                        Capsule(style: .continuous)
                            .frame(height: 3)
                            .offset(y: 5)
                            .foregroundColor(.black.opacity(0.7))
                    }
                Text("Обновляем контент...")
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundColor(.black)
                    .padding(.top, 10)
                    .padding(.horizontal, 40)
                ProgressView()
                Spacer()
                Spacer()
            }
            .multilineTextAlignment(.center)
        }
    }
}

struct CustomLoadingView_Previews: PreviewProvider {
    static var previews: some View {
        CustomLoadingView()
    }
}
