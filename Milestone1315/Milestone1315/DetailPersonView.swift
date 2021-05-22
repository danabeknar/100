//
//  DetailPersonView.swift
//  Milestone1315
//
//  Created by Beknar Danabek on 22.05.21.
//

import SwiftUI

struct DetailPersonView: View {
    let person: Person
    
    var body: some View {
        VStack {
            Image(uiImage: person.image)
                .resizable()
                .scaledToFit()
        }
        .navigationTitle(person.name)
    }
}

struct DetailPersonView_Previews: PreviewProvider {
    static var previews: some View {
        DetailPersonView(person: Person(name: "test", image: UIImage()))
    }
}
