//
//  PersonMapView.swift
//  Milestone1315
//
//  Created by Beknar Danabek on 22.05.21.
//

import SwiftUI
import MapKit

struct PersonMapView: UIViewRepresentable {
    let centerCoordinate: CLLocationCoordinate2D
    
    func makeUIView(context: Context) -> some UIView {
        let mapView = MKMapView()
        mapView.centerCoordinate = centerCoordinate
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: centerCoordinate.latitude,
                                                       longitude: centerCoordinate.longitude)
        mapView.addAnnotation(annotation)
        
        return mapView
    }

    func updateUIView(_ uiView: UIViewType, context: Context) {
    }
}


struct PersonMapView_Previews: PreviewProvider {
    static var previews: some View {
        PersonMapView(centerCoordinate: MKPointAnnotation.example.coordinate)
    }
}
