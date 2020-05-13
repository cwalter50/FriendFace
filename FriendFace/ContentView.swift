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
                    VStack {
                        Text(user.name)
                        Text(user.about)
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
//    func loadDataFromInternet() {
//        guard let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json") else {
//            debugPrint("Invalid URL")
//            return
//        }
//        let request = URLRequest(url: url)
//        URLSession.shared.dataTask(with: request) { data, response, error in
//            if let data = data {
//                if let decodedResponse = try? JSONDecoder().decode([User].self, from: data) {
//                    DispatchQueue.main.async {
//                        self.users.userList = decodedResponse
//                    }
//                    return
//                }         }
//            debugPrint("fetch failed: \(error?.localizedDescription ?? "Unknown error")")
//        }.resume()
//    }
    
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
