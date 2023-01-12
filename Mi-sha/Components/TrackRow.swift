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
    var container: AppDependency
    
    init(track: TrackModel, container: AppDependency) {
        self.container = container
        self.track = track
        self.progress = container.userProgress
    }
    
    var body: some View {
        ZStack {
            NavigationLink(destination: PlayerView(model: track, container: container), label: {
                HStack(spacing: 0) {
                    Text(track.number)
                        .font(.caption)
                        .frame(width: 30)
                    if progress.checkDone(model: track) {
                        Circle()
                            .foregroundColor(Color.theme.orange)
                            .frame(width: 30, height: 30)
                    } else if track.number == progress.nextMeditation(){
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
                    
                    Text(track.name)
                        .font(.callout)
                        .lineLimit(1)
                        .minimumScaleFactor(0.6)
                        .padding(.leading, 20)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        
                    Spacer()
                    Text(DateComponentsFormatter.abbreviated.string(from: track.duration) ?? track.duration.formatted() + "s")
                        .font(.caption)
                        .lineLimit(1)
//                        .frame(width: 60)
                        
                    Image(systemName: "heart")
                        .foregroundColor(Color.theme.purple)
                        .frame(width: 30, height: 30)
//                        .frame(width: UIScreen.main.bounds.width / 3.5)
                }
                .font(.labGrotesque(.medium, size: 16))
                .frame(height: 55)
//                .frame(maxWidth: .infinity)
            })
            .buttonStyle(.plain)
        }
    }
}

struct TrackRow_Previews: PreviewProvider {
    static var previews: some View {
        TrackRow(track: dev.track, container: dev.dependencyContainer)
    }
}
