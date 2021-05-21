//
//  AccessibleMission.swift
//  Moonshot
//
//  Created by Beknar Danabek on 21.05.21.
//  Copyright © 2021 Beknar Danabek. All rights reserved.
//

import Foundation

struct AccessibleMission {
    let mission: Mission
    
    var description: String {
        "Description" + mission.description
    }
    
    var date: String {
        if let launchDate = mission.launchDate {
            let formatter = DateFormatter()
            formatter.dateStyle = .long
            return formatter.string(from: launchDate)
        } else {
            return "Date is missing"
        }
    }
    
    func crewNames(astronauts: [Astronaut]) -> String {
        "Crew names are: " + mission.crewNames(from: astronauts)
    }
}
