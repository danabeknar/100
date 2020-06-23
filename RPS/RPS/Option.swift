//
//  Option.swift
//  RPS
//
//  Created by Beknar Danabek on 6/23/20.
//  Copyright © 2020 Beknar Danabek. All rights reserved.
//

import Foundation

enum Option: CustomStringConvertible, CaseIterable {
    case rock
    case paper
    case scissors
    
    var description: String {
        switch self {
        case .rock:
            return "Rock"
        case .paper:
            return "Paper"
        case .scissors:
            return "Scissors"
        }
    }
}
