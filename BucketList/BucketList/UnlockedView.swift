//
//  UnlockedView.swift
//  BucketList
//
//  Created by Beknar Danabek on 20.05.21.
//

import SwiftUI
import MapKit

struct UnlockedView: View {
    @Binding var centerCoordinate: CLLocationCoordinate2D
    @Binding var locations: [CodableMKPointAnnotation]
    @Binding var selectedPlace: MKPointAnnotation?
    @Binding var showingPlaceDetails: Bool
    @Binding var showingEditScreen: Bool
    
    var body: some View {
        ZStack {
            MapView(centerCoordinate: $centerCoordinate,
                    selectedPlace: $selectedPlace,
                    showingPlaceDetails: $showingPlaceDetails,
                    annotations: locations)
                .edgesIgnoringSafeArea(.all)
            Circle()
                .fill(Color.blue)
                .opacity(0.3)
                .frame(width: 32, height: 32)
            
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button(action: {
                        let newLocation = CodableMKPointAnnotation()
                        newLocation.coordinate = centerCoordinate
                        newLocation.title = "Example location"
                        locations.append(newLocation)
                        selectedPlace = newLocation
                        showingEditScreen = true
                    }) {
                        Image(systemName: "plus")
                            .padding()
                            .background(Color.black.opacity(0.75))
                            .foregroundColor(.white)
                            .font(.title)
                            .clipShape(Circle())
                            .padding(.trailing)
                    }
                }
            }
        }
        .sheet(isPresented: $showingEditScreen, onDismiss: saveData) {
            if selectedPlace != nil {
                EditView(placemark: selectedPlace!)
            }
        }
    }
    
    func saveData() {
        do {
            let filename = getDocumentsDirectory().appendingPathComponent("SavedPlaces")
            let data = try JSONEncoder().encode(self.locations)
            try data.write(to: filename, options: [.atomicWrite, .completeFileProtection])
        } catch {
            print("Unable to save data.")
        }
    }
    
    func getDocumentsDirectory() -> URL {
        // find all possible documents directories for this user
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)

        // just send back the first one, which ought to be the only one
        return paths[0]
    }
}

struct UnlockedView_Previews: PreviewProvider {
    static var newLocation: CodableMKPointAnnotation  {
        let newLocation =  CodableMKPointAnnotation()
        newLocation.coordinate = CLLocationCoordinate2D(latitude: 51.5, longitude: -0.13)
        newLocation.title = "Example location"
        return newLocation
    }
    
    static var previews: some View {
        UnlockedView(centerCoordinate: .constant(MKPointAnnotation.example.coordinate),
                     locations: .constant([newLocation]),
                     selectedPlace: .constant(MKPointAnnotation.example),
                     showingPlaceDetails: .constant(false),
                     showingEditScreen: .constant(false))
    }
}
