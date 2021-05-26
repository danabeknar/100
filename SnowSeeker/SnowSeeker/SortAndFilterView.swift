//
//  SortAndFilterView.swift
//  SnowSeeker
//
//  Created by Beknar Danabek on 26.05.21.
//

import SwiftUI

enum SortType: String, CaseIterable {
    case `default` = "Default"
    case alphabetical = "Alphabetical"
    case country = "Country"
}

extension Array where Element: Hashable {
    func removingDuplicates() -> [Element] {
        var addedDict = [Element: Bool]()

        return filter {
            addedDict.updateValue(true, forKey: $0) == nil
        }
    }

    mutating func removeDuplicates() {
        self = self.removingDuplicates()
    }
}

struct SortAndFilterView: View {
    let resorts: [Resort]
    @Binding var sortType: SortType
    @Binding var selectedCountry: String
    @Binding var selectedSize: String
    @Binding var selectedPrice: String
    
    @Environment(\.presentationMode) var presentationMode
    
    var sortTypes = SortType.allCases
    
    private var countries: [String] {
        var countries = resorts.map { $0.country }.removingDuplicates().sorted()
        countries.insert("All", at: 0)
        return countries
    }
    
    private var sizes: [String] {
        var sizes = resorts.map { String($0.size) }.removingDuplicates().sorted()
        sizes.insert("All", at: 0)
        return sizes
    }
    
    private var prices: [String] {
        var prices = resorts.map { String($0.price) }.removingDuplicates().sorted()
        prices.insert("All", at: 0)
        return prices
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Picker(selection: $sortType, label: Text("Select sort type")) {
                    ForEach(sortTypes, id: \.self) {
                        Text($0.rawValue)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                
                Form {
                    Section(header: Text("Country")) {
                        List {
                            ForEach(countries, id: \.self) { country in
                                HStack {
                                    Text(country)
                                    Spacer()
                                    if selectedCountry == country {
                                        Image(systemName: "checkmark")
                                    }
                                }
                                .contentShape(Rectangle())
                                .onTapGesture {
                                    selectedCountry = country
                                }
                            }
                        }
                    }
                    
                    Section(header: Text("Size")) {
                        List {
                            ForEach(sizes, id: \.self) { size in
                                HStack {
                                    Text(size)
                                    Spacer()
                                    if selectedSize == size {
                                        Image(systemName: "checkmark")
                                    }
                                }
                                .contentShape(Rectangle())
                                .onTapGesture {
                                    selectedSize = size
                                }
                            }
                        }
                    }
                    
                    Section(header: Text("Price")) {
                        List {
                            ForEach(prices, id: \.self) { price in
                                HStack {
                                    Text(price)
                                    Spacer()
                                    if selectedPrice == price {
                                        Image(systemName: "checkmark")
                                    }
                                }
                                .contentShape(Rectangle())
                                .onTapGesture {
                                    selectedPrice = price
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle("Sort")
            .navigationBarItems(
                trailing: (
                    Button("Save") {
                        dismiss()
                    }
                )
            )
        }
    }
    
    func dismiss() {
        presentationMode.wrappedValue.dismiss()
    }
}

struct SortAndFilterView_Previews: PreviewProvider {
    static var previews: some View {
        SortAndFilterView(resorts: [Resort.example],
                          sortType: .constant(.default),
                          selectedCountry: .constant("All"),
                          selectedSize: .constant("All"),
                          selectedPrice: .constant("All"))
    }
}
