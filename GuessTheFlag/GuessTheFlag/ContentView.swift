//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Beknar Danabek on 6/18/20.
//  Copyright © 2020 Beknar Danabek. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            Color(red: 1, green: 0.8, blue: 0).edgesIgnoringSafeArea(.all)
            Text("Your content")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
