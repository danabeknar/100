//
//  ContentView.swift
//  Edutainment
//
//  Created by Beknar Danabek on 6/29/20.
//  Copyright © 2020 Beknar Danabek. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var multiplicationTable = 1
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Select multiplication table")) {
                    Picker("", selection: $multiplicationTable) {
                        ForEach (1..<11) { number in
                            Text("\(number)")
                        }
                    }
                .pickerStyle(WheelPickerStyle())
                .labelsHidden()
                }
            }
        .navigationBarTitle("Edutainment")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
