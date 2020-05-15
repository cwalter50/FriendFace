//
//  UserView.swift
//  FriendFace
//
//  Created by Christopher Walter on 5/14/20.
//  Copyright © 2020 Christopher Walter. All rights reserved.
//

import SwiftUI

struct UserView: View {
    var userList: [User]
    var userId: String
    var user: User
    
    var body: some View {
        ScrollView(.vertical)
        {
            VStack(alignment: .leading) {
                HStack{
                    Circle()
                        .frame(width: 20, height: 20)
                        .foregroundColor(user.activeColor)
                    Text(self.user.name)
                    .font(.largeTitle)
                    .padding()
                }
                
                Text(self.user.displayTags)
                    .foregroundColor(.secondary)
                Text("About:")
                    .underline()
                    .padding(.top, 10)
                Text(self.user.about)
                    .padding(.bottom, 10)
                Text("Company: \(self.user.company)")
                Text("Address: \(self.user.address)")
                Text("Email: \(self.user.email)")
                
                Text("Friends")
                    .underline()
                    .font(.title)
                    .padding(.top, 10)
                ForEach(self.user.friends, id: \.id) { friend in
                    NavigationLink(destination: UserView(userList: self.userList, userId: friend.id)) {
                        Text(friend.name)
                        .padding(5)
                    }
                    
                
                
                }
            }
            
        }
        .padding(.horizontal)
        .navigationBarTitle(Text(user.name), displayMode: .inline)
    }
    
    init(userList: [User], userId: String) {
        guard let user = userList.first(where: { (u) -> Bool in
            u.id == userId
        }) else {
            fatalError("Invalid user.")
        }
        
        self.user = user
        self.userList = userList
        self.userId = userId
    }
}

struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        
        let testUser = User()
        let testUserList = [testUser]
        return UserView(userList: testUserList, userId: "123")
    }
}
