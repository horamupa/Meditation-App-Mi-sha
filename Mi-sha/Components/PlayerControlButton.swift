//
//  PlayerControlButton.swift
//  Mi-sha
//
//  Created by MM on 08.12.2022.
//

import SwiftUI

struct PlayerControlButton: View {
    var systemName: String = "play"
    var fontSize: CGFloat = 24
    var color: Color = .white
    var action: () -> Void
    var body: some View {
        Button {
            action()
        } label: {
            Image(systemName: systemName)
                .font(.system(size: fontSize))
                .foregroundColor(color)
        }

    }
}

struct PlayerControlButton_Previews: PreviewProvider {
    static var previews: some View {
        PlayerControlButton(action: { } )
            .preferredColorScheme(.dark)
    }
}
