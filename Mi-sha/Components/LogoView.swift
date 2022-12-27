//
//  LogoView.swift
//  Mi-sha
//
//  Created by MM on 26.12.2022.
//

import SwiftUI

struct LogoView: View {
    var body: some View {
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
    }
}

struct LogoView_Previews: PreviewProvider {
    static var previews: some View {
        LogoView()
    }
}
