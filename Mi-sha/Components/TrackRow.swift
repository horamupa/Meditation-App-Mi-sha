//
//  TrackRow.swift
//  Mi-sha
//
//  Created by MM on 16.12.2022.
//

import SwiftUI

struct TrackRow: View {
    
    @ObservedObject var progress = ProgressInfo.shared
    
    let track: TrackModel
    var body: some View {
        ZStack {
            NavigationLink(destination: PlayerView(model: track), label: {
                HStack {
                    if progress.checkDone(model: track) {
                        Image(systemName: "checkmark.circle")
                            .foregroundColor(.green)
                    } else {
                        Image(systemName: "checkmark.circle")
                            .opacity(0.3)
                    }
                    Text(track.name).bold()
                        .minimumScaleFactor(0.5)
                    Spacer()
                    Text(DateComponentsFormatter.abbreviated.string(from: track.duration) ?? track.duration.formatted() + "s")
                    Image(systemName: "heart.fill")
                        .foregroundColor(.red)
                }
                .frame(height: 55)
                .padding(20)
            })
            .buttonStyle(.plain)
        }
    }
}

struct TrackRow_Previews: PreviewProvider {
    static var previews: some View {
        TrackRow(track: dev.track)
    }
}
