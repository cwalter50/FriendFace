//
//  CDUser+CoreDataProperties.swift
//  FriendFace
//
//  Created by Christopher Walter on 5/17/20.
//  Copyright © 2020 Christopher Walter. All rights reserved.
//
//

import Foundation
import CoreData



extension CDUser {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDUser> {
        return NSFetchRequest<CDUser>(entityName: "CDUser")
    }

    @NSManaged public var name: String?
    @NSManaged public var age: Int16
    @NSManaged public var company: String?
    @NSManaged public var email: String?
    @NSManaged public var about: String?
    @NSManaged public var isActive: Bool
    @NSManaged public var registered: String?
    @NSManaged public var id: String?
    @NSManaged public var address: String?
    @NSManaged public var tags: String?
    @NSManaged public var friends: String?
    

    
    var wrappedName: String {
        return name ?? "Doc"
    }

    var wrappedCompany: String {
        return company ?? "Bones-R-Us"
    }
    var wrappedEmail: String {
        return email ?? "doc@gmail.com"
    }
    var wrappedAbout: String {
        return about ?? "Best Dog in the World"
    }
    var wrappedRegistered: String {
        return registered ?? "Error"
    }
    var wrappedID : String {
        return id ?? "Error"
    }
    var wrappedAddress: String {
        return address ?? "123 Fake Street"
    }
//    var friendsArray: [String] {
////        let idList: [String] = friends?.components(separatedBy: ",") ?? []
//
//        return friends?.components(separatedBy: ",") ?? []
//    }
//    var tagsArray: [String] {
//        return tags?.components(separatedBy: ",") ?? []
//    }
    
    var user: User {
        
        let decodedFriends = try! JSONDecoder().decode([Friend].self, from: friends!.data(using: .utf8)!)
        let decodedTags = try! JSONDecoder().decode([String].self, from: tags!.data(using: .utf8)!)
        
        return User(name: wrappedName, age: age, company: wrappedCompany, email: wrappedEmail, address: wrappedAddress, isActive: isActive, about: wrappedAbout, registered: wrappedRegistered, id: wrappedID, tags: decodedTags, friends: decodedFriends)
    }
    
    func setProperties(from user: User) {
        id = user.id
        isActive = user.isActive
        name = user.name
        age = user.age
        company = user.company
        email = user.email
        address = user.address
        about = user.about
        registered = user.registered
        let tagsData = try! JSONEncoder().encode(user.tags)
        tags = String(data: tagsData, encoding: .utf8)
        let friendsData = try! JSONEncoder().encode(user.friends)
        friends = String(data: friendsData, encoding: .utf8)
    }
    

}
