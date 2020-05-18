//
//  ContentView.swift
//  FriendFace
//
//  Created by Christopher Walter on 5/13/20.
//  Copyright © 2020 Christopher Walter. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var users = Users()
    
    // CoreData Stuff
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: CDUser.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \CDUser.name, ascending: true)]) var cdUsers: FetchedResults<CDUser>
    
    
    var body: some View {
        NavigationView {
            List {
                ForEach (users.userList) {
                    user in
                    NavigationLink(destination: UserView(userList: self.users.userList, userId: user.id)) {
                        
                        HStack {
                            Circle()
                            .frame(width: 25, height: 25)
                                .foregroundColor(user.activeColor)
                            Text(user.name)
                                .font(.title)
                        }
                    }
                    
                }
            }
        .navigationBarTitle("FriendFace")
        .onAppear(perform: loadData)
        }
    }
    

    func loadData() {
        
//        print("load data from internet")
//        loadDataFromInternet()
        
        if cdUsers.count == 0 {
            print("load data from internet")
            loadDataFromInternet()
        } else {
            print("load data from core data")
            loadDataFromCoreData()
        }
           
    }

    
    func loadDataFromInternet() {
        let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json")!
        let request = URLRequest(url: url)

        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                fatalError("No data in response.")
            }

            if let decoded = try? JSONDecoder().decode([User].self, from: data) {
                DispatchQueue.main.async {
                    self.users.userList = decoded.sorted(by: { (u1, u2) -> Bool in
                        u1.name < u2.name
                    })
                }
                // save to CoreData, so that next time, I do not need to load from the internet.
                self.saveDataToCoreData(decoded)
            } else {
                fatalError("Invalid response from server.")
            }
        }.resume()
    }
    
    func saveDataToCoreData(_ data: [User]) {
        for user in data {
            let cdUser = CDUser(context: moc)
            cdUser.setProperties(from: user)
        }
        try! moc.save()
    }
    
    func loadDataFromCoreData() {
        
        // cdUsers are grabbed in the fetchResults at the top of this struct. Place them as type User into the userList...
        users.userList = cdUsers.map {
            $0.user
        }
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
