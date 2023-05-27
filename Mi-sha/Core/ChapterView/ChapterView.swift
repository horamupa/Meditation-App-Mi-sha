//
//  CourseView.swift
//  Mi-sha
//
//  Created by MM on 16.12.2022.
//

import SwiftUI

struct ChapterView: View {
    @Environment(\.dismiss) var dismiss
    var innerCourse: CourseModel
    
    var body: some View {
        ZStack {
            Color.theme.white
                .ignoresSafeArea()
            
                VStack(alignment: .leading, spacing: 0) {
                    upperBlock
                    
                    ScrollView {
                    VStack(alignment: .leading, spacing: 5) {
            
                        ForEach(innerCourse.tracks.sorted()) { track in
                            TrackRow(track: track)
                        }
//                        Spacer()
                    }
                }
                .padding(.horizontal, 10)
            }
            .listStyle(.plain)
            
        }
        .ignoresSafeArea()
        .foregroundColor(Color.theme.black)
        .accentColor(Color.theme.black)
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    dismiss()
                } label: {
                    HStack {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.black)
                        Text("Назад")
                    }
                }
            }
        }
    }
}

struct CourseView_Previews: PreviewProvider {
    static var previews: some View {
        ChapterView(innerCourse: dev.course)
    }
}

extension ChapterView {
    var upperBlock: some View {
        ZStack(alignment: .bottomTrailing) {
            Color(innerCourse.color)
            VStack {
                Image(innerCourse.image )
                    .resizable()
                    .scaledToFit()
                .cornerRadius(10)
                Text(innerCourse.name)
                    .font(.labGrotesque(.medium))
                    .padding(10)
                    .frame(maxWidth: .infinity)
                    .background(.ultraThinMaterial)
            }
        }
        .frame(height: 250)
        .cornerRadius(20)
    }
}
