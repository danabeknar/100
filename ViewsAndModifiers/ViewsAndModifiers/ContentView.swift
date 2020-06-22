//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by Beknar Danabek on 6/20/20.
//  Copyright © 2020 Beknar Danabek. All rights reserved.
//

import SwiftUI

struct ProminentTitle: ViewModifier {
    var text: String
    
    func body(content: Content) -> some View {
        ZStack(alignment: .topLeading) {
            content
            
            Text(text)
                .padding(5)
                .font(.largeTitle)
                .foregroundColor(.blue)
        }
    }
}

extension View {
    func withProminentTitle(text: String) -> some View {
        self.modifier(ProminentTitle(text: text))
    }
}

struct ContentView: View {
    var body: some View {
        Color.red
            .frame(width: 200, height: 200)
            .withProminentTitle(text: "Hello, World")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
