//
//  ContentView.swift
//  Edutainment
//
//  Created by Beknar Danabek on 6/29/20.
//  Copyright © 2020 Beknar Danabek. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var isSettingsActive = true
    
    var body: some View {
        Group {
            if isSettingsActive {
                SettingsView(onStart: {
                    self.isSettingsActive = false
                })
            } else {
                Text("Hello world")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
