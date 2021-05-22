//
//  Person.swift
//  Milestone1315
//
//  Created by Beknar Danabek on 22.05.21.
//

import UIKit
import CoreLocation

class Person: Codable, Identifiable, Comparable, ObservableObject {
    var id = UUID()
    var name: String
    var image: UIImage
    var coordinate: CodableMKPointAnnotation
    private var imageData: Data
    
    enum CodingKeys: String, CodingKey {
        case id, name, coordinate, imageData
    }
    
    init() {
        name = ""
        image = UIImage()
        imageData = Data()
        coordinate = CodableMKPointAnnotation()
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        imageData = image.pngData()!
        try container.encode(imageData, forKey: .imageData)
        try container.encode(coordinate, forKey: .coordinate)
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decode(UUID.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        imageData = try container.decode(Data.self, forKey: .imageData)
        coordinate = try container.decode(CodableMKPointAnnotation.self, forKey: .coordinate)
        image = UIImage(data: imageData)!
    }
    
    static func == (lhs: Person, rhs: Person) -> Bool {
        lhs.id == rhs.id && lhs.name == rhs.name
    }
    
    static func < (lhs: Person, rhs: Person) -> Bool {
        lhs.name < rhs.name
    }
}
