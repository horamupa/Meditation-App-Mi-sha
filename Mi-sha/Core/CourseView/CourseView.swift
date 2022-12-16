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
                            .cornerRadius(25)
                        Text(innerCourse.name)
                            .font(.labGrotesque(.medium))
                            .padding(.horizontal, 20)
                    }
                    VStack(alignment: .leading) {
                        
                        ForEach(innerCourse.tracks) { track in
                            TrackRow(track: track)
                                .background(.thinMaterial)
                                .cornerRadius(10)
                        }
                        Spacer()
                    }
                    .padding()
                }
                
            }
        }
    }
}

struct CourseView_Previews: PreviewProvider {
    static var previews: some View {
        CourseView(innerCourse: dev.course)
    }
}
