//
//  ContentView.swift
//  SnowSeeker
//
//  Created by Beknar Danabek on 26.05.21.
//

import SwiftUI


extension View {
    func phoneOnlyStackNavigationView() -> some View {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return AnyView(self.navigationViewStyle(StackNavigationViewStyle()))
        } else {
            return AnyView(self)
        }
    }
}

struct ContentView: View {
    @State private var filteredResorts: [Resort] = Bundle.main.decode("resorts.json")
    @ObservedObject var favorites = Favorites()
    
    @State private var showSorting = false
    @State private var sortType: SortType = .default
    @State private var selectedCountry = "All"
    @State private var selectedSize = "All"
    @State private var selectedPrice = "All"
    private let resorts: [Resort] = Bundle.main.decode("resorts.json")
    
    var body: some View {
        NavigationView {
            List(filteredResorts) { resort in
                NavigationLink(destination: ResortView(resort: resort)) {
                    Image(resort.country)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 40, height: 25)
                        .clipShape(
                            RoundedRectangle(cornerRadius: 5)
                        )
                        .overlay(
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(Color.black, lineWidth: 1)
                        )
                    
                    VStack(alignment: .leading) {
                        Text(resort.name)
                            .font(.headline)
                        Text("\(resort.runs) runs")
                            .foregroundColor(.secondary)
                    }
                    .layoutPriority(1)
                    
                    if self.favorites.contains(resort) {
                        Spacer()
                        Image(systemName: "heart.fill")
                            .accessibility(label: Text("This is a favorite resort"))
                            .foregroundColor(.red)
                    }
                }
            }
            .navigationBarTitle("Resorts")
            .navigationBarItems(trailing: (
                Button(action: {
                    showSorting = true
                }, label: {
                    Image(systemName: "line.horizontal.3.decrease.circle")
                })
            )
            )
            
            WelcomeView()
        }
        .environmentObject(favorites)
        .phoneOnlyStackNavigationView()
        .sheet(isPresented: $showSorting, onDismiss: sortResorts) {
            SortAndFilterView(resorts: resorts,
                              sortType: $sortType,
                              selectedCountry: $selectedCountry,
                              selectedSize: $selectedSize,
                              selectedPrice: $selectedPrice)
        }
    }
    
    func sortResorts() {
        var resorts = self.resorts
        if sortType == .alphabetical {
            resorts.sort(by: { $0.name > $1.name })
        } else if sortType == .country {
            resorts.sort(by: { $0.country > $1.country })
        }
        
        if selectedCountry != "All" {
            resorts = resorts.filter { $0.country == selectedCountry }
        }
        
        if selectedSize != "All" {
            resorts = resorts.filter { String($0.size) == selectedSize }
        }
        
        if selectedPrice != "All" {
            resorts = resorts.filter { String($0.price) == selectedPrice }
        }
        
        filteredResorts = resorts
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
