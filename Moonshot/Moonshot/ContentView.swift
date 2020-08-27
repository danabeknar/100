//
//  ContentView.swift
//  Moonshot
//
//  Created by Beknar Danabek on 8/27/20.
//  Copyright © 2020 Beknar Danabek. All rights reserved.
//

import SwiftUI

struct CustomText: View {
    var text: String
    
    var body: some View {
        Text(text)
    }
    
    init(_ text: String) {
        self.text = text
        print("Creating a custom text")
    }
}

struct ContentView: View {
    var body: some View {
        List {
            ForEach(0..<100) {
                CustomText("Item \($0)")
                    .font(.title)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
