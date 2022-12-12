//
//  XmarkButton.swift
//  Mi-sha
//
//  Created by MM on 12.12.2022.
//

import SwiftUI

struct XmarkButton: View {
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        Button {
            presentationMode.wrappedValue.dismiss()
        } label: {
            Image(systemName: "xmark")
                .font(.headline)
                .foregroundColor(.black)
        }

    }
}

struct XmarkButton_Previews: PreviewProvider {
    static var previews: some View {
        XmarkButton()
    }
}
