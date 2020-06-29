//
//  SettingsView.swift
//  Edutainment
//
//  Created by Beknar Danabek on 6/29/20.
//  Copyright © 2020 Beknar Danabek. All rights reserved.
//

import SwiftUI

struct SettingsView: View {
    @State private var multiplicationTable = 1
    
    @State private var questions = ["5", "10", "15", "All"]
    @State private var selectedQuestionsCount = 0
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Select multiplication table:")) {
                    Picker("", selection: $multiplicationTable) {
                        ForEach (1..<11) { index in
                            Text("\(index)")
                        }
                    }
                    .pickerStyle(WheelPickerStyle())
                    .labelsHidden()
                }
                
                Section(header: Text("How many questions you want to be asked?")) {
                    Picker("", selection: $selectedQuestionsCount) {
                        ForEach (0..<questions.count) { index in
                            Text("\(self.questions[index])")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Button(action: {
                    // TODO
                }, label: {
                    HStack {
                        Spacer()
                        Text("Start")
                        Spacer()
                    }
                })
            }
            .navigationBarTitle("Edutainment")
        }
    }
}
