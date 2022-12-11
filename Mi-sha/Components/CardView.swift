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
                    .frame(maxWidth: .infinity, alignment: .topLeading)
                Image("stones")
                    .resizable()
                    .cornerRadius(30)
                Image(systemName: "play.circle")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 45, height: 45)
                    .padding(5)
                    .frame(maxWidth: .infinity, alignment: .bottomTrailing)
            }
            .padding(30)
            .foregroundColor(.white)
        }
        .frame(width: 300, height: 400)
//        .frame(width: UIScreen.main.bounds.width / 1.3, height: UIScreen.main.bounds.height / 2)
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(model: dev.model)
    }
}
