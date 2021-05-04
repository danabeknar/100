//
//  Friend+CoreDataProperties.swift
//  Milestone1012
//
//  Created by Beknar Danabek on 4.05.21.
//
//

import Foundation
import CoreData


extension Friend {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Friend> {
        return NSFetchRequest<Friend>(entityName: "Friend")
    }

    @NSManaged public var id: String?
    @NSManaged public var name: String?
    
    var wrappedName: String {
        name ?? "Unknown name"
    }

}

extension Friend : Identifiable {

}
