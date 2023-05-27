//
//  BackButtonView.swift
//  Mi-sha
//
//  Created by MM on 27.05.2023.
//
import SwiftUI

struct BackButton: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var foregroundColor: Color
    
    var body: some View {
        Button(action: { presentationMode.wrappedValue.dismiss()}) {
            HStack {
                Image(systemName: "arrowLeft")
                    .foregroundColor(foregroundColor)
                    .aspectRatio(contentMode: .fit)
                Text("Назад")
                    .foregroundColor(foregroundColor)
            }
        }
    }
}
