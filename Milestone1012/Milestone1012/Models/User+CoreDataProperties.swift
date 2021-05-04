//
//  User+CoreDataProperties.swift
//  Milestone1012
//
//  Created by Beknar Danabek on 4.05.21.
//
//

import Foundation
import CoreData

extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var id: String?
    @NSManaged public var isActive: Bool
    @NSManaged public var name: String?
    @NSManaged public var age: NSNumber?
    @NSManaged public var company: String?
    @NSManaged public var email: String?
    @NSManaged public var address: String?
    @NSManaged public var about: String?
    @NSManaged public var registered: String?
    @NSManaged public var tags: [String]?
    @NSManaged public var friends: [Friend]?
    
    var wrappedName: String {
        name ?? "Unknown name"
    }
    
    var wrappedAge: Int {
        age?.intValue ?? 0
    }
    
    var wrappedCompany: String {
        company ?? "Unknown Company"
    }
    
    var wrappedEmail: String {
        email ?? "Unknown Email"
    }
    
    var wrappedAddress: String {
        address ?? "Unknown Address"
    }
    
    var wrappedAbout: String {
        about ?? "Unknown About"
    }
    
    var wrappedRegistered: String {
        registered ?? "Unknown registered"
    }
    
    var wrappedTags: [String] {
        tags ?? []
    }
    
    var wrappedFriends: [Friend] {
        friends ?? []
    }
}

extension User : Identifiable {

}
