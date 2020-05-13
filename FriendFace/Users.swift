//
//  Users.swift
//  FriendFace
//
//  Created by Christopher Walter on 5/13/20.
//  Copyright © 2020 Christopher Walter. All rights reserved.
//

import Foundation

class Users: ObservableObject {
    @Published var userList = [User]()
}
