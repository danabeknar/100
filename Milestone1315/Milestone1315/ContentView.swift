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
    
    var body: some View {
        VStack {
            Button("Select a picture") {
                showingPicker.toggle()
            }
        }
        .sheet(isPresented: $showingPicker) {
            ImagePickerView(image: $image)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
