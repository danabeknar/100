//
//  ContentView.swift
//  Milestone1012
//
//  Created by Beknar Danabek on 4.05.21.
//

import SwiftUI

struct ContentView: View {
    @State private var users: [User] = []
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(users, id: \.id) { user in
                        NavigationLink(destination: UserView(user: user)) {
                            Text(user.wrappedName)
                        }
                    }
                }
            }.navigationBarTitle("Users")
        }.onAppear(perform: loadData)
    }

func loadData() {
    guard let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json") else {
        print("Invalid URL")
        return
    }
    let request = URLRequest(url: url)
    URLSession.shared.dataTask(with: request) { data, response, error in
        if let data = data {
            let decoder = JSONDecoder()
            decoder.userInfo[CodingUserInfoKey.managedObjectContext] = PersistenceController.shared.container.viewContext
            if let users = try? decoder.decode([User].self, from: data) {
                DispatchQueue.main.async {
                    self.users = users
                }

                return
            }
        }
    }.resume()
}
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
