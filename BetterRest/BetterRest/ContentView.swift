//
//  ContentView.swift
//  BetterRest
//
//  Created by Beknar Danabek on 6/24/20.
//  Copyright © 2020 Beknar Danabek. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var wakeUp = defaultWakeTime
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 1
    
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showingAlert = false
    
    private var accessibleSleepAmount: String {
        if floor(sleepAmount) == sleepAmount {
            return String(format: "%g", Double(sleepAmount)) + " hours"
        }

        let hours = Int(floor(sleepAmount))
        let minutesDecimal = sleepAmount - floor(sleepAmount)
        let minutes = Int(minutesDecimal * 60)
        return "\(hours) hours and " + "\(minutes) minutes"
    }
    
    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        
        return Calendar.current.date(from: components) ?? Date()
    }
    
    var body: some View {
        NavigationView {
            Form {
                
                Section(header: Text("When do you want to wake up?")) {
                    DatePicker("Please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                        .datePickerStyle(WheelDatePickerStyle())
                }
                
                Section(header: Text("Desired amount of sleep")) {
                    Stepper(value: $sleepAmount, in: 4...12, step: 0.25) {
                        Text("\(sleepAmount, specifier: "%g") hours")
                    }
                    .accessibility(value: Text(accessibleSleepAmount))
                }
                
                Section(header: Text("Daily coffee intake")) {
                    Picker("Test", selection: $coffeeAmount) {
                        ForEach (1..<20) { number in
                            if number == 1 {
                                Text("\(number) cup")
                                    .accessibility(label: Text("\(number) cup out of 20"))
                            } else {
                                Text("\(number) cups")
                                    .accessibility(label: Text("\(number) cups out of 20"))
                            }
                        }
                    }
                    .labelsHidden()
                }
                
                Section(header: Text("Your ideal bedtime is")) {
                    Text(calculateBedtime())
                        .font(.callout)
                }
            }
            .navigationBarTitle("BetterRest")
        }
    }
    
    func calculateBedtime() -> String {
        let model = SleepCalculator()
        
        let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
        
        let hour = (components.hour ?? 0) * 60 * 60
        let minute = (components.minute ?? 0) * 60
        
        do {
            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
            
            let sleepTime = wakeUp - prediction.actualSleep
            let formatter = DateFormatter()
            formatter.timeStyle = .short
            
            return formatter.string(from: sleepTime)
        } catch {
            return "Sorry, there was a problem calculating your bedtime."
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
