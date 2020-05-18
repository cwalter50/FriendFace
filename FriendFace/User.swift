//
//  User.swift
//  FriendFace
//
//  Created by Christopher Walter on 5/13/20.
//  Copyright © 2020 Christopher Walter. All rights reserved.
//

import Foundation
import SwiftUI

struct User: Codable, Identifiable
{
    
    var name: String
    var age: Int16
    var company: String
    var email: String
    var address : String
    var isActive: Bool
    var about: String
    var registered: String // Maybe Date
    var id: String

    var tags: [String]

    var friends: [Friend]

    init(name: String, age: Int16, company: String, email: String, address: String, isActive: Bool, about: String, registered: String, id: String, tags: [String], friends: [Friend] )
    {
        self.name = name
        self.age = age
        self.company = company
        self.email = email
        self.address = address
        self.isActive = isActive
        self.about = about
        self.registered = registered
        self.id = id
        self.tags = tags
        self.friends = friends
    }
    init()
    {
        name = "Test"
        age = 25
        company = "Apple"
        email = "test@gmail.com"
        address = "123 Fake Street"
        isActive = false
        about = "This could be a long storyh with a lot of stuff in it. Doc is my favorite Dog in the World. I love my wife Beth and daughter Isabella."
        registered = "2015-11-10T01:47:18-00:00"
        id = "123"
        tags = ["Cool", "Funny", "Smart"]
        friends = []
    }
    
    
    var displayRegistered: String {
        String(registered.replacingOccurrences(of: "T", with: " ").dropLast(6))
    }
    
    var displayTags: String {
        tags.joined(separator: "  ")
    }
    
    var sortedFriends: [Friend] {
        friends.sorted { (f1, f2) -> Bool in
            f1.name < f2.name
        }
    }
    
    var activeColor : Color {
        if isActive
        {
            return Color.green
        }
        else
        {
            return Color.red
        }
    }
    
    func saveToCoreData()
    {
        
    }
    
    func readFromCoreData()
    {
        
    }
    

}


