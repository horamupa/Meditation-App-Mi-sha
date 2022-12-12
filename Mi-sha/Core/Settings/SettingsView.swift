//
//  Settings.swift
//  Mi-sha
//
//  Created by MM on 12.12.2022.
//

import SwiftUI

struct SettingsView: View {
    
    @State var userName = "UserName"
    
    var defaultURL = URL(string: "https://www.google.com")!
    var secondURL = URL(string: "https://www.youtube.com")!
    var coffeURL = URL(string: "https://www.buymeacoin.com")!
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            VStack {
                Image("stones")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 150, height: 150)
                    .clipShape(Circle())
                Text(userName)
                List {
                    Section("User Info") {
                        HStack {
                            Text("Your name is")
                            Spacer()
                            Text("\(userName)")
                                
                        }
                        HStack {
                            Text("Number of session done")
                            Spacer()
                            Text("30")
                        }
                        HStack {
                            Text("Minutes spended in meditation")
                            Spacer()
                            Text("4200")
                        }
                        HStack {
                            Text("Your Status")
                            Spacer()
                            Text("Unbelievable hero")
                        }
                    }
                    Section("Common Links") {
                        Link("Terms of service", destination: defaultURL)
                        Link("Privacy policy", destination: secondURL)
                    }
                    Section("Buy me a coffe") {
                        Link("Buy me a coffe☕️", destination: coffeURL)
                    }
                }
                .navigationTitle("Settings")
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button {
                            dismiss()
                        } label: {
                            Image(systemName: "xmark")
                                .foregroundColor(.black)
                        }

                    }
                }
            .listStyle(.grouped )
            }
        }
    }
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
