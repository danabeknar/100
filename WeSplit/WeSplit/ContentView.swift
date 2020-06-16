//
//  ContentView.swift
//  WeSplit
//
//  Created by Beknar Danabek on 6/14/20.
//  Copyright © 2020 Beknar Danabek. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = ""
    @State private var numberOfPeople = ""
    @State private var tipPercantage = 2
    
    private let tipPercentages = [10, 15, 20, 25, 0]
    
    private var peopleCount: Double {
        Double(Int(numberOfPeople) ?? 0)
    }
    
    private var tipSelection: Double {
        Double(tipPercentages[tipPercantage])
    }
    
    private var orderAmount: Double {
        Double(checkAmount) ?? 0
    }
    
    private var totalPerPerson: Double {
        (orderAmount + (orderAmount*tipSelection)/100)/peopleCount
    }
    
    private var totalAmount: Double {
        orderAmount + (orderAmount*tipSelection)/100
    }
     
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", text: $checkAmount)
                        .keyboardType(.decimalPad)
                    
                    TextField("Number of people", text: $numberOfPeople)
                            .keyboardType(.decimalPad)
                }
                
                Section(header: Text("How much tip do you want to leave?")) {
                    Picker("Tip percentage", selection: $tipPercantage) {
                        ForEach(0 ..< tipPercentages.count) {
                            Text("\(self.tipPercentages[$0])%")
                        }
                    }
                .pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("Amount per person")) {
                    Text("$ \(totalPerPerson, specifier: "%.2f")")
                }
                
                Section(header: Text("Total amount")) {
                    Text("$ \(totalAmount, specifier: "%.2f")")
                }
            }
        .navigationBarTitle("We Split")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
