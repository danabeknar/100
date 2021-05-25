//
//  ResortView.swift
//  SnowSeeker
//
//  Created by Beknar Danabek on 26.05.21.
//

import SwiftUI

struct ResortView: View {
    let resort: Resort
    
    @Environment(\.horizontalSizeClass) var sizeClass
    
    @State private var selectedFacility: Facility?
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                Image(decorative: resort.id)
                    .resizable()
                    .scaledToFit()
                
                HStack {
                    if sizeClass == .compact {
                        Spacer()
                        VStack { ResortDetailsView(resort: resort) }
                        VStack { SkiDetailsView(resort: resort) }
                        Spacer()
                    } else {
                        ResortDetailsView(resort: resort)
                        Spacer().frame(height: 0)
                        SkiDetailsView(resort: resort)
                    }
                    
                }
                .font(.headline)
                .foregroundColor(.secondary)
                .padding(.top)
                
                Group {
                    Text(resort.description)
                        .padding(.vertical)
                    
                    Text("Facilities")
                        .font(.headline)
                    
                    HStack {
                        ForEach(resort.facilityTypes) { facility in
                               facility.icon
                                   .font(.title)
                                   .onTapGesture {
                                       self.selectedFacility = facility
                                   }
                           }
                    }
                    .padding(.vertical)
                }
                .padding(.horizontal)
            }
        }
        .alert(item: $selectedFacility) { facility in
            facility.alert
        }
        .navigationBarTitle(Text("\(resort.name), \(resort.country)"),
                            displayMode: .inline)
    }
}

struct ResortView_Previews: PreviewProvider {
    static var previews: some View {
        ResortView(resort: Resort.example)
    }
}
