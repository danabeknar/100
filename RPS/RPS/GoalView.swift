//
//  GoalView.swift
//  RPS
//
//  Created by Beknar Danabek on 6/23/20.
//  Copyright © 2020 Beknar Danabek. All rights reserved.
//

import SwiftUI

struct GoalView: View {
    var goal: Goal
    
    var body: some View {
        HStack {
            Text("You should")
            Text(goal.rawValue)
                .padding(.leading, -5)
                .foregroundColor(goal == .win ? .green : .red)
        }
    }
}
