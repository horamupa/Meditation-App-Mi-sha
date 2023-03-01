//
//  TrackRow.swift
//  Mi-sha
//
//  Created by MM on 16.12.2022.
//

import SwiftUI

struct TrackRow: View {
    
    @ObservedObject var progress = UserProgress.shared
    
    let track: TrackModel
    
    var body: some View {
        ZStack {
            NavigationLink(destination: PlayerView(model: track), label: {
                HStack(spacing: 0) {
                    Text("\(track.number)")
                        .font(.caption)
                        .frame(width: 30)
                    if progress.checkDone(model: track) {
                        Circle()
                            .foregroundColor(Color.theme.orange)
                            .frame(width: 30, height: 30)
                        } else {
                            Circle()
                                .foregroundColor(Color.theme.orange)
                                .frame(width: 30, height: 30)
                                .opacity(0.3)
                                .overlay {
                                    Circle()
                                        .frame(width: 25, height: 25)
                                        .foregroundColor(.white)
                                }
                        
                    }
                    
                    Text(track.name)
                        .font(.callout)
                        .lineLimit(1)
                        .minimumScaleFactor(0.6)
                        .padding(.leading, 20)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        
                    Spacer()
                    HStack(spacing: 4) {
                        Text(DateComponentsFormatter.positional.string(from: track.duration) ?? track.duration.formatted() + "s")
                            .lineLimit(1)
                        Text("мин")
                            .padding(.trailing, 16)
                    }
                    .font(.caption)
//                    Image(systemName: "heart")
//                        .foregroundColor(Color.theme.purple)
//                        .frame(width: 30, height: 30)
                }
                .font(.labGrotesque(.medium, size: 16))
                .frame(height: 55)
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
