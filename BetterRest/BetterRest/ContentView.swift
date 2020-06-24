//
//  ContentView.swift
//  BetterRest
//
//  Created by Beknar Danabek on 6/24/20.
//  Copyright © 2020 Beknar Danabek. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var wakeUp = Date()
    
    var body: some View {
        let now = Date()
        let tomorrow = Date().addingTimeInterval(864000)
        let range = now ... tomorrow
        
        DatePicker("Please enter a date",
                   selection: $wakeUp,
                   in: Date()...)
            .labelsHidden()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
