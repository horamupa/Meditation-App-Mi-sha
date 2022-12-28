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
            Color.theme.main
                .ignoresSafeArea()

            VStack(spacing: 40) {
                ZStack {
                    Circle()
                        .frame(width: 120, height: 120)
                        .foregroundColor(.white.opacity(0.4))
                        .cornerRadius(10)
                        .blur(radius: 10)
                    ZStack(alignment: .bottomLeading) {
                        Circle()
                            .frame(width: 80, height: 80)
                            .foregroundColor(Color(#colorLiteral(red: 0.9607843137, green: 0.6274509804, blue: 0.4196078431, alpha: 1)))
                        Circle()
                            .frame(width: 55, height: 55)
                            .foregroundColor(Color(#colorLiteral(red: 1, green: 0.7725490196, blue: 0.2666666667, alpha: 1)))
                            .blur(radius: 1)
                    }
                }
                .padding(.vertical, 20)
                .offset(x: 90, y: 30)
                Image("home1")
                    .resizable()
                    .scaledToFill()
                    .scaleEffect(1.1)
                    .offset(x: -10)
//                Text("Медитации Мёд")
//                    .font(.largeTitle)
//                    .fontWeight(.medium)
//                    .foregroundColor(.black.opacity(0.7))
//                    .overlay(alignment: .bottom) {
//                        Capsule(style: .continuous)
//                            .frame(height: 3)
//                            .offset(y: 5)
//                            .foregroundColor(.black.opacity(0.7))
//                    }
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
