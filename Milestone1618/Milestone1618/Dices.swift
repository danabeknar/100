//
//  Dices.swift
//  Milestone1618
//
//  Created by Beknar Danabek on 25.05.21.
//

import Foundation

class DicesStore: ObservableObject {
    @Published var dices = [String]()
    
    func add(_ dice: String) {
        dices.append(dice)
    }
}
