//
//  PersonView.swift
//  Milestone1315
//
//  Created by Beknar Danabek on 22.05.21.
//

import SwiftUI

struct PersonView: View {
    let person: Person
    
    var body: some View {
        HStack {
            Image(uiImage: person.image)
                .resizable()
                .scaledToFit()
                .frame(width: 44, height: 44)
            
            Text(person.name)
                .font(.headline)
        }
    }
}

struct PersonView_Previews: PreviewProvider {
    static var previews: some View {
        PersonView(person: Person(name: "Test", image: UIImage()))
    }
}
