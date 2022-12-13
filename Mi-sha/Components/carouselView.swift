//
//  carouselView.swift
//  Mi-sha
//
//  Created by MM on 12.12.2022.
//

import SwiftUI

struct carouselView<Content: View,T: Identifiable>: View {
    var content: (T) -> Content
    var list: [T]
    //propirties
    var spacing: CGFloat
    var trailingSpace:CGFloat
    @Binding var index: Int
    
    init(spacing: CGFloat = 15, trailingSpace: CGFloat = 100, index: Binding<Int>, items: [T], @ViewBuilder content: @escaping (T)-> Content) {
        self.list = items
        self.spacing = spacing
        self.trailingSpace = trailingSpace
        self._index = index
        self.content = content
    }
    
    //offset
    @GestureState var offset: CGFloat = 0
    @State var currentIndex: Int = 0
    var body: some View {
        GeometryReader {proxy in
            
            let width = proxy.size.width - (trailingSpace - spacing)
            let adjastMentWidth = (trailingSpace / 2) - spacing
            HStack(spacing: spacing) {
                ForEach(list) { item in
                    content(item)
                        .frame(width: proxy.size.width - trailingSpace)
                }
            }
            .padding(.horizontal, spacing)
            .offset(x: (CGFloat(currentIndex) * -width) + (currentIndex != 0 ? adjastMentWidth : 0) + offset)
            .gesture(
            DragGesture()
                .updating($offset, body: { value, out, _ in
                    out = value.translation.width
                })
                .onEnded({ value in
                    //updatiing current undex
                    let offsetx = value.translation.width
                    let progress = -offsetx / width
                    let roundIndex = progress.rounded()
                    currentIndex = max(min(currentIndex + Int(roundIndex), list.count - 1), 0)
                    
                    currentIndex = index
                })
                .onChanged({ value in
                    let offsetx = value.translation.width
                    let progress = -offsetx / width
                    let roundIndex = progress.rounded()
                    index = max(min(currentIndex + Int(roundIndex), list.count - 1), 0)
           
                })
            )
        }
        //animating when offset = 0
        .animation(.easeOut, value: offset == 0)
    }
}

struct carouselView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(dev.vm)
            .environmentObject(AudioManager())
    }
}
