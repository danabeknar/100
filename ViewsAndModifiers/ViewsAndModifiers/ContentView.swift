//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by Beknar Danabek on 6/20/20.
//  Copyright © 2020 Beknar Danabek. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var useRedText = false

    var body: some View {
        VStack {
            Text("Gryffindor")
                .font(.largeTitle)
            Text("Hufflepuff")
            Text("Ravenclaw")
            Text("Slytherin")
        }
        .font(.title)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
