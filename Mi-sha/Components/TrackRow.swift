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
                HStack(spacing: 0) {
                    Text(track.number)
                        .font(.caption)
                        .frame(minWidth: 30)
                    if progress.checkDone(model: track) {
                        Circle()
                            .foregroundColor(Color.theme.orange)
                            .frame(width: 30, height: 30)
                    } else {
                        if track.number == ProgressInfo.shared.nextMeditation() {
                            Circle()
                                .foregroundColor(Color.theme.orange)
                                .frame(width: 30, height: 30)
                                .opacity(0.3)
                                .overlay {
                                    Circle()
                                        .frame(width: 25, height: 25)
                                        .foregroundColor(.white)
                                        .overlay {
                                            Image(systemName: "chevron.forward")
                                                .frame(width: 30, height: 30)
                                                .foregroundColor(Color.theme.orange)
                                                .opacity(0.5)
                                        }
                                }
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
                    }
                    Spacer()
                    Text(track.name)
                        .font(.callout)
                        .minimumScaleFactor(0.1)
                    Spacer()
                    Text(DateComponentsFormatter.abbreviated.string(from: track.duration) ?? track.duration.formatted() + "s")
                        
                    Image(systemName: "heart")
                        .foregroundColor(Color.theme.purple)
                        .frame(width: 60, height: 30)
//                        .padding(.trailing, 20)
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
