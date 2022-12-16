//
//  TrackRow.swift
//  Mi-sha
//
//  Created by MM on 16.12.2022.
//

import SwiftUI

struct TrackRow: View {
    let track: TrackModel
    var body: some View {
        HStack {
            Text(track.name)
            Spacer()
            Image(systemName: "play.fill")
                .foregroundColor(Color.theme.blue)
            Image(systemName: "heart.fill")
                .foregroundColor(.red)
        }
        .padding()
    }
}

struct TrackRow_Previews: PreviewProvider {
    static var previews: some View {
        TrackRow(track: dev.track)
    }
}
