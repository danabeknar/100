//
//  TemperatureUnit.swift
//  Temperature
//
//  Created by Beknar Danabek on 6/17/20.
//  Copyright © 2020 Beknar Danabek. All rights reserved.
//

import Foundation

enum TemperatureUnit: String, CaseIterable {
    case celcius, fahreinheit, kelvin
    
    init(from index: Int) {
        switch index {
        case 0:
            self = .celcius
        case 1:
            self = .fahreinheit
        case 2:
            self = .kelvin
        default:
            self = .celcius
        }
    }
    
    var unit: UnitTemperature {
        switch self {
        case .celcius:
            return UnitTemperature.celsius
        case .fahreinheit:
            return UnitTemperature.fahrenheit
        case .kelvin:
            return UnitTemperature.kelvin
        }
    }
}
