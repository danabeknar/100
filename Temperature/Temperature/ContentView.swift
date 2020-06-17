//
//  ContentView.swift
//  Temperature
//
//  Created by Beknar Danabek on 6/17/20.
//  Copyright © 2020 Beknar Danabek. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var inputValue = ""
    @State private var inputUnit = 0
    @State private var outputUnit = 1
    
    private var units = TemperatureUnit.allCases
    
    private var outputValue: String {
        return Measure(inputUnit: inputUnit, outputUnit: outputUnit, inputValue: inputValue).value
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Input")) {
                    TextField("Value", text: $inputValue)
                    
                    Picker("Convert unit", selection: $inputUnit) {
                        ForEach(0..<units.count) {
                            Text(self.units[$0].rawValue.firstUppercased)
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("Output")) {
                    Picker("Convert unit", selection: $outputUnit) {
                        ForEach(0..<units.count) {
                            Text(self.units[$0].rawValue.firstUppercased)
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                    Text(outputValue)
                }
            }
        .navigationBarTitle("Temperature")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
