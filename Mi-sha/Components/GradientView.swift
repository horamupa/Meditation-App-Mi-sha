//
//  RadientView.swift
//  Mi-sha
//
//  Created by MM on 26.12.2022.
//

import SwiftUI

struct GradientView: View {
    var body: some View {
        RadialGradient(
            gradient: Gradient(colors: [Color(#colorLiteral(red: 1, green: 0.8323456645, blue: 0.4732058644, alpha: 1)), Color(#colorLiteral(red: 1, green: 0.4932718873, blue: 0.4739984274, alpha: 1))]),
            center: .topLeading, startRadius: 200, endRadius: 600)
        .ignoresSafeArea()
    }
}

struct RadientView_Previews: PreviewProvider {
    static var previews: some View {
        GradientView()
    }
}
