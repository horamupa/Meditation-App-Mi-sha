//
//  HomeNextCourseView.swift
//  Mi-sha
//
//  Created by MM on 27.12.2022.
//

import SwiftUI

struct HomeNextCourseView: View {
    var model: TrackModel
    /// <#Description#>
    var body: some View {
        
        ZStack {
            ZStack {
                Image(model.image ?? "home1")
                        .resizable()
                        .scaledToFill()
//                        .frame(height: 250)
//                        .frame(minWidth: 400)
                    .foregroundColor(Color.theme.orange)
                    .overlay(alignment: .bottomTrailing) {
                        HStack {
                            Text("\(model.id):" ?? "Next Series:")
                                .font(.labGrotesque(.medium, size: 16))
                                .shadow(radius: 0)
                            Text(model.name ?? "Start your journey here")
                                .font(.labGrotesque(.medium, size: 16))
                                .shadow(radius: 0)
                            
                            Image(systemName: "play.circle")
                                .scaleEffect(2.5)
                                .foregroundColor(Color.theme.white)
                                .frame(width: 50, height: 50)
                            
                        }
//                        .frame(maxWidth: .infinity)
                        .padding(5)
                        .padding(.horizontal, 20)
                        .background(.ultraThinMaterial)
                        .cornerRadius(15)
                    }
                
            }
//            .frame(height: 250)
//            .padding()
            }
    }
}

struct HomeNextCourseView_Previews: PreviewProvider {
    static var previews: some View {
        HomeNextCourseView(model: dev.track)
    }
}
