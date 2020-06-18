//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Beknar Danabek on 6/18/20.
//  Copyright © 2020 Beknar Danabek. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var showingAlert = false
    
    var body: some View {
        Button("Show Alert") {
            self.showingAlert = true
        }
        .alert(isPresented: $showingAlert) {
            Alert(title: Text("Title"), message: Text("Message"), dismissButton: .default(Text("Ok")))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
