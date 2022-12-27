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
            ScrollView {
                VStack(alignment: .leading) {
                    ZStack(alignment: .bottomTrailing) {
                        Rectangle()
                            .frame(height: 250)
                            .foregroundColor(Color(innerCourse.image))
                            .cornerRadius(10)
                        Text(innerCourse.name)
                            .font(.labGrotesque(.medium))
                            .padding(10)
                            .frame(maxWidth: .infinity)
                            .background(.ultraThinMaterial)
                    }
                    .cornerRadius(25)
                    VStack(alignment: .leading, spacing: 5) {
                        
                        ForEach(innerCourse.tracks.sorted(by: { $0.number < $1.number
                        })) { track in
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
