//
//  ContentView.swift
//  iExpense
//
//  Created by Beknar Danabek on 8/19/20.
//  Copyright © 2020 Beknar Danabek. All rights reserved.
//

import SwiftUI

class User {
    var firstName: String = "Bilbo"
    var lastName: String = "Beggins"
}

struct ContentView: View {
    @State private var user = User()
    
    var body: some View {
        VStack {
            Text("Your name is \(user.firstName) \(user.lastName).")
            TextField("First name", text: $user.firstName)
            TextField("Second name", text: $user.lastName)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
