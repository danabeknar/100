//
//  StringProtocol+FirstUppercased.swift
//  Temperature
//
//  Created by Beknar Danabek on 6/17/20.
//  Copyright © 2020 Beknar Danabek. All rights reserved.
//

import Foundation

extension StringProtocol {
    var firstUppercased: String {
        prefix(1).uppercased() + dropFirst()
    }
}
