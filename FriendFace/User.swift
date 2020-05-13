//
//  User.swift
//  FriendFace
//
//  Created by Christopher Walter on 5/13/20.
//  Copyright © 2020 Christopher Walter. All rights reserved.
//

import Foundation

struct User: Codable, Identifiable
{
    
    var name: String
    var age: Int
    var company: String
    var email: String
    var isActive: Bool
    var about: String
    var registered: String // Maybe Date
    var id: String

    var tags: [String]

    var friends: [Friend]
    

}


