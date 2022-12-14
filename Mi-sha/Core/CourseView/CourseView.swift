//
//  CourseView.swift
//  Mi-sha
//
//  Created by MM on 16.12.2022.
//

import SwiftUI

struct CourseView: View {
    
    var innerCourse: CourseModel
    var body: some View {
        ZStack {
            
                VStack(alignment: .leading) {
                    ZStack(alignment: .bottomTrailing) {
                        Image(innerCourse.image )
                            .resizable()
                            .scaledToFill()
                            .frame(height: 250)
                            .cornerRadius(10)
                        Text(innerCourse.name)
                            .font(.labGrotesque(.medium))
                            .padding(10)
                            .frame(maxWidth: .infinity)
                            .background(.ultraThinMaterial)
                    }
                    .cornerRadius(25)
                    ScrollView {
                    VStack(alignment: .leading, spacing: 5) {
                        
                        ForEach(innerCourse.tracks.sorted()) { track in
                            TrackRow(track: track)
//                                .background(.thinMaterial)
//                                .cornerRadius(10)
                        }
                        Spacer()
                    }

                }
                
            }
            .listStyle(.plain)
            
        }
        
        .ignoresSafeArea()
    }
}

struct CourseView_Previews: PreviewProvider {
    static var previews: some View {
        CourseView(innerCourse: dev.course)
    }
}
