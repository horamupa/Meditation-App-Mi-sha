//
//  BagesView.swift
//  Mi-sha
//
//  Created by MM on 04.01.2023.
//

import SwiftUI

struct BagesView: View {
    var body: some View {
        ZStack {
            Circle()
                .frame(width: 100, height: 100)
                .foregroundColor(Color.theme.orange)
        }
    }
}

struct BagesView_Previews: PreviewProvider {
    static var previews: some View {
        BagesView()
    }
}
