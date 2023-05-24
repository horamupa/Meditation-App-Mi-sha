//
//  HomeNextCourseView.swift
//  Mi-sha
//
//  Created by MM on 27.12.2022.
//

import SwiftUI

struct HomeNextCourseView: View {
    var model: TrackModel
    var body: some View {
        
        ZStack(alignment: .bottomLeading) {
            Color.theme.main
            Image("home1") //model.image ??
                    .resizable()
                    .scaledToFit()
                    .offset(y: -20)
                    .frame(maxWidth: .infinity)
                .foregroundColor(Color.theme.orange)
                .overlay(alignment: .bottom) {
                    HStack(alignment: .center,spacing: 5) {

                        HStack {
                            Text("\(model.id):" )
                                .font(.labGrotesque(.regular, size: 18))
                                .foregroundColor(Color.theme.black)
                                .shadow(radius: 0)
                                .font(.labGrotesque(.thin,size: 13))
                            Text(model.name )
                                .font(.labGrotesque(.medium, size: 20))
                                .foregroundColor(Color.theme.black)
                                .shadow(radius: 0)
                                .minimumScaleFactor(0.6)
                        }
                        
                        
                        Image(systemName: "play.circle")
                            .scaleEffect(1.7)
                            .foregroundColor(Color.theme.orange.opacity(0.7))
                            .frame(width: 50, height: 40)
                            .shadow(color: Color.theme.orange.opacity(0.2), radius: 2, y: 2)
                    }
                    
                    .frame(maxWidth: .infinity, alignment: .bottomLeading)
                    .frame(minHeight: 48)
                    .padding(.leading, 24)
                    .padding(.vertical, 4)
                    .background(.regularMaterial.opacity(0.9))
                    .cornerRadius(0)
                    .environment(\.colorScheme, .light)
                    .shadow(color: Color.theme.orange.opacity(0.4), radius: 2)
                    
                    
                }
//                    .shadow(radius: 10)
            
        }
        .cornerRadius(15)
    }
}

struct HomeNextCourseView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            HomeView()
                .environmentObject(dev.vm)
                .environmentObject(AVManager.shared)
        }
    }
}
