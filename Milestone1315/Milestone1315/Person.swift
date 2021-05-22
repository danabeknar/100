//
//  Person.swift
//  Milestone1315
//
//  Created by Beknar Danabek on 22.05.21.
//

import UIKit

struct Person: Codable, Identifiable, Comparable {
    var id = UUID()
    let name: String
    let imageData: Data
    
    init(name: String, image: UIImage) {
        self.name = name
        imageData = image.pngData()!
    }
    
    var image: UIImage {
        UIImage(data: imageData)!
    }
    
    static func < (lhs: Person, rhs: Person) -> Bool {
        lhs.name < rhs.name
    }
}
