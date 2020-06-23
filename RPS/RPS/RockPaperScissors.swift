//
//  RockPaperScissors.swift
//  RPS
//
//  Created by Beknar Danabek on 6/23/20.
//  Copyright © 2020 Beknar Danabek. All rights reserved.
//

import Foundation

struct RockPaperScissors {
    var option: Option = Option.allCases.randomElement()!
    var goal = Goal.allCases.randomElement()!
    
    func isCorrect(guess: Option) -> Bool {
        switch goal {
        case .win:
            return isWinner(guess, over: option)
        case .lose:
            return isWinner(option, over: guess)
        }
    }
    
    private func isWinner(_ shouldWin: Option, over shouldLose: Option) -> Bool {
        switch shouldWin {
        case .rock:
            return shouldLose == .scissors
        case .paper:
            return shouldLose == .rock
        case .scissors:
            return shouldLose == .paper
        }
    }
}
