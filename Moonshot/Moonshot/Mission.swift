//
//  Mission.swift
//  Moonshot
//
//  Created by Beknar Danabek on 8/29/20.
//  Copyright © 2020 Beknar Danabek. All rights reserved.
//

import Foundation

struct Mission: Codable, Identifiable {
    struct CrewRole: Codable {
        let name: String
        let role: String
    }

    let id: Int
    let launchDate: Date?
    let crew: [CrewRole]
    let description: String
    
    var displayName: String {
        "Apollo \(id)"
    }

    var image: String {
        "apollo\(id)"
    }
    
    var formattedLaunchDate: String {
        if let launchDate = launchDate {
            let formatter = DateFormatter()
            formatter.dateStyle = .long
            return formatter.string(from: launchDate)
        } else {
            return "N/A"
        }
    }
    
    func contains(_ astronaut: Astronaut) -> Bool {
        return crew.map { $0.name }.contains(astronaut.id)
    }
    
    func crewNames(from astronauts: [Astronaut]) -> String {
        var result = ""

        for member in crew {
            if let match = astronauts.first(where: { $0.id == member.name }) {
                result += match.name + ", "
            } else {
                fatalError("Crew member \(member.name) not found")
            }
        }

        return String(result.dropLast(2))
    }
}
