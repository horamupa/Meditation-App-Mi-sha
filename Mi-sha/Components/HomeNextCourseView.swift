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
                        .offset(y: -20)
//                        .frame(height: 250)
//                        .frame(minWidth: 400)
                    .foregroundColor(Color.theme.orange)
                    .overlay(alignment: .bottomTrailing) {
                        HStack(spacing: 5) {
    
                            Text("\(model.id) :" ?? "Next Series:")
                                .font(.labGrotesque(.semibold, size: 18))
                                .shadow(radius: 0)
                          
                            .font(.labGrotesque(.thin,size: 13))
                            Text(model.name ?? "Start your journey here")
                                .font(.labGrotesque(.semibold, size: 18))
                                .shadow(radius: 0)
                                .minimumScaleFactor(0.6)
                            
                            Image(systemName: "play.circle")
                                .scaleEffect(2)
                                .foregroundColor(Color.theme.orange.opacity(0.7))
                                .frame(width: 50, height: 40)
                                .shadow(color: Color.theme.orange.opacity(0.5), radius: 2, y: 2)
                        }
                        
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 20)
                        .padding(.vertical, 4)
                        .background(.regularMaterial.opacity(0.9))
                        .cornerRadius(10)
                        .shadow(color: Color.theme.orange.opacity(0.4), radius: 2)
                        
                        
                    }
//                    .shadow(radius: 10)
                
            }
//            .frame(height: 250)
//            .padding()
            }
    }
}

struct HomeNextCourseView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            HomeView()
                .environmentObject(dev.vm)
                .environmentObject(AudioManager.shared)
        }
    }
}
