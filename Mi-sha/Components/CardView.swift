//
//  CardView.swift
//  Mi-sha
//
//  Created by MM on 08.12.2022.
//

import SwiftUI

struct CardView: View {
    
    var model: AudioModel
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 30)
                .foregroundColor(Color.theme.black)
            VStack(alignment: .leading) {
                Text(model.name)
                    .font(.headline)
                ZStack(alignment: .bottomTrailing) {
                    Image(model.image ?? "stones")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 300, height: 350)
                        .cornerRadius(30)
                    Image(systemName: "play.circle")
                        .resizable()
                        .frame(width: 45, height: 45)
                        .padding(5)
                        .clipped()
                        .background(.thinMaterial.opacity(0.3))
                        .cornerRadius(30)
                        .padding(5)
                }
            }
            .padding(20)
            .foregroundColor(.white)
        }
        .frame(width: 320, height: 450)
//        .frame(width: UIScreen.main.bounds.width / 1.3, height: UIScreen.main.bounds.height / 2)
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(model: dev.model)
    }
}
