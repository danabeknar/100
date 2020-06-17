//
//  Measure.swift
//  Temperature
//
//  Created by Beknar Danabek on 6/17/20.
//  Copyright © 2020 Beknar Danabek. All rights reserved.
//

import Foundation

class Measure {
    var value: String {
        guard let input = inputValue, let inputValue = Double(input) else {
            return ""
        }
        
        let inputMeasurement = Measurement(value: inputValue, unit: inputUnit.unit)
        let outputMeasurement = inputMeasurement.converted(to: outputUnit.unit)
        let output = formatter.string(from: outputMeasurement)
        
        return output
    }
    
    private lazy var formatter: MeasurementFormatter = {
       let formatter = MeasurementFormatter()
       formatter.numberFormatter.maximumFractionDigits = 2
       formatter.unitOptions = .providedUnit
        
        return formatter
    }()
    
    private let inputUnit: TemperatureUnit
    private let outputUnit: TemperatureUnit
    private var inputValue: String?
    
    init(inputUnit: Int, outputUnit: Int, inputValue: String?) {
        self.inputUnit = TemperatureUnit(from: inputUnit)
        self.outputUnit = TemperatureUnit(from: outputUnit)
        self.inputValue = inputValue
    }
}
