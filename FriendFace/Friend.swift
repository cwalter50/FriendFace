//
//  Friend.swift
//  FriendFace
//
//  Created by Christopher Walter on 5/13/20.
//  Copyright © 2020 Christopher Walter. All rights reserved.
//

import Foundation

struct Friend: Codable, Identifiable
{
    var name: String
    var id: UUID
}
