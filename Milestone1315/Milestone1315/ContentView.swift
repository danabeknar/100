//
//  ContentView.swift
//  Milestone1315
//
//  Created by Beknar Danabek on 22.05.21.
//

import SwiftUI

struct ContentView: View {
    @State private var showingPicker = false
    @State private var image: UIImage?
    @State private var showingNamingAlert = false
    @State private var name = ""
    
    var body: some View {
        ZStack {
            VStack {
                Button("Select a picture") {
                    showingPicker.toggle()
                }
            }
            
            if showingNamingAlert {
                NameAlertView(name: $name, onDismiss: saveImageAndName)
            }
        }
        .sheet(isPresented: $showingPicker, onDismiss: askUserToNamePhotoIfNeeded) {
            ImagePickerView(image: $image)
        }
    }
    
    private func askUserToNamePhotoIfNeeded() {
        if image == nil { return }
        
        showingNamingAlert = true
    }
    
    private func saveImageAndName() {
        showingNamingAlert = false
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
