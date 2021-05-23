//
//  ContentView.swift
//  Flashzilla
//
//  Created by Beknar Danabek on 23.05.21.
//

import SwiftUI
import CoreHaptics

struct ContentView: View {
    @Environment(\.accessibilityReduceTransparency) var reduceTransparency
    var body: some View {
        Text("Hello, World!")
            .padding()
            .background(reduceTransparency ? Color.black : Color.black.opacity(0.5))
            .foregroundColor(Color.white)
            .clipShape(Capsule())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
