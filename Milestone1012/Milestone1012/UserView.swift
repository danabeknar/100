//
//  UserView.swift
//  Milestone1012
//
//  Created by Beknar Danabek on 4.05.21.
//

import SwiftUI

struct UserView: View {
    var user: User
    
    var body: some View {
        VStack {
            List {
                UserTextView(key: "Is active", value: user.isActive ? "True" : "False")
                UserTextView(key: "Age", value: "\(String(describing: user.wrappedAge))")
                UserTextView(key: "Company", value: user.wrappedCompany)
                UserTextView(key: "Address", value: user.wrappedAddress)
                UserTextView(key: "Email", value: user.wrappedEmail)
                UserTextView(key: "About", value: user.wrappedAbout)
                UserTextView(key: "Registered", value: user.wrappedRegistered)
                UserTextView(key: "Tags", value: user.wrappedTags.joined(separator: ","))
                UserTextView(key: "Friends", value: user.wrappedFriends.map { $0.wrappedName }.joined(separator: ","))
            }
            .navigationBarTitle(user.wrappedName)
        }
    }
}

struct UserTextView: View {
    var key: String
    var value: String
    
    var body: some View {
        HStack {
            Text(key).padding(.trailing, 16)
            Spacer()
            Text(value)
        }
    }
}

struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        UserView(user: User())
    }
}
