//
//  Friend+CoreDataClass.swift
//  Milestone1012
//
//  Created by Beknar Danabek on 4.05.21.
//
//

import Foundation
import CoreData

@objc(Friend)
public class Friend: NSManagedObject, Decodable {
    enum CodingKeys: CodingKey {
        case id, name
    }
    
    public required convenience init(from decoder: Decoder) throws {
        guard let context = decoder.userInfo[CodingUserInfoKey.managedObjectContext] as? NSManagedObjectContext else {
          throw DecoderConfigurationError.missingManagedObjectContext
        }

        self.init(context: context)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decode(String.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
    }
}
