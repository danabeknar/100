//
//  PersonAlertView.swift
//  Milestone1315
//
//  Created by Beknar Danabek on 22.05.21.
//

import SwiftUI
import MapKit

struct PersonAlertView: View {
    @ObservedObject var person: Person
    var onDismiss: () -> Void
    let locationFetcher = LocationFetcher()
    
    @State private var centerCoordinate = CLLocationCoordinate2D()
    
    var body: some View {
        ZStack() {
            Color.gray
                .edgesIgnoringSafeArea(.all)
            VStack {
                HStack {
                    Text("Please enter a name below")
                        .font(.footnote)
                        .foregroundColor(.gray)
                    Spacer()
                }
                TextField("Name", text: $person.name)
                    .padding(.bottom)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                HStack {
                    Text("Please select your location")
                        .font(.footnote)
                        .foregroundColor(.gray)
                    
                    Button("Read location") {
                        if let location = locationFetcher.lastKnownLocation {
                            centerCoordinate = location
                        }
                    }
                }
                
                ZStack {
                    MapView(centerCoordinate: $centerCoordinate)
                    Circle()
                        .fill(Color.blue)
                        .opacity(0.3)
                        .frame(width: 32, height: 32)
                }

                Button("Save") {
                    let coordinate = CodableMKPointAnnotation()
                    coordinate.coordinate = centerCoordinate
                    person.coordinate = coordinate
                    onDismiss()
                }
            }
            .padding()
            .frame(width: 300, height: 300, alignment: .center)
            .background(Color.white)
            .cornerRadius(20).shadow(radius: 20)
        }
        .onAppear(perform: startTrackingLocation)
    }
    
    private func startTrackingLocation() {
        locationFetcher.start()
    }
}

struct PersonAlertView_Previews: PreviewProvider {
    static var previews: some View {
        PersonAlertView(person: Person(),
                        onDismiss: {})
    }
}
