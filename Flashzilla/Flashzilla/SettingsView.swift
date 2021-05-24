//
//  SettingsView.swift
//  Flashzilla
//
//  Created by Beknar Danabek on 24.05.21.
//

import SwiftUI

struct SettingsView: View {
    @Binding var shouldCardsGoBack: Bool
    @Environment(\.presentationMode) private var presentationMode
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Gameplay")) {
                    HStack {
                        Text("Infinite game")
                        Spacer()
                        Toggle("Infinite game", isOn: $shouldCardsGoBack)
                            .labelsHidden()
                    }
                }
            }
            .navigationViewStyle(StackNavigationViewStyle())
            .navigationBarItems(trailing: Button("Done", action: dismiss))
            .navigationBarTitle("Settings")
        }
    }
    
    func dismiss() {
        presentationMode.wrappedValue.dismiss()
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(shouldCardsGoBack: .constant(true))
    }
}
