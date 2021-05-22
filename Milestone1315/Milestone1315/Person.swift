//
//  Person.swift
//  Milestone1315
//
//  Created by Beknar Danabek on 22.05.21.
//

import UIKit

struct Person: Codable, Identifiable {
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
}
