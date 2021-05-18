//
//  ContentView.swift
//  BucketList
//
//  Created by Beknar Danabek on 18.05.21.
//

import SwiftUI

struct ContentView: View {
    let users = [
        User(firstName: "Arnold", lastName: "Rimmer"),
        User(firstName: "Kristine", lastName: "Kochanski"),
        User(firstName: "David", lastName: "Lister"),
    ].sorted()
    
    var body: some View {
        List(users) { user in
                    Text("\(user.lastName), \(user.firstName)")
                }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
