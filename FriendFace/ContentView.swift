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
        
        print("load data from internet")
        loadDataFromInternet()
           
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

//                self.saveDataToCoreData(decoded)
            } else {
                fatalError("Invalid response from server.")
            }
        }.resume()
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
