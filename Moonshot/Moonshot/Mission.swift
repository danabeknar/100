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
    let launchDate: String?
    let crew: [CrewRole]
    let description: String
}
