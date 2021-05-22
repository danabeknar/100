//
//  DetailPersonView.swift
//  Milestone1315
//
//  Created by Beknar Danabek on 22.05.21.
//

import SwiftUI
import MapKit

struct DetailPersonView: View {
    let person: Person
    
    var body: some View {
        VStack {
            Image(uiImage: person.image)
                .resizable()
                .scaledToFit()
            
            PersonMapView(centerCoordinate: CLLocationCoordinate2D(latitude: person.coordinate.coordinate.latitude,
                                                                   longitude: person.coordinate.coordinate.longitude))
        }
        .navigationTitle(person.name)
    }
}

struct DetailPersonView_Previews: PreviewProvider {
    static var previews: some View {
        DetailPersonView(person: Person())
    }
}
