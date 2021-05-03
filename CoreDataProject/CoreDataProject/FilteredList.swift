//
//  FilteredList.swift
//  CoreDataProject
//
//  Created by Beknar Danabek on 3.05.21.
//

import SwiftUI
import CoreData

struct FilteredList<T: NSManagedObject, Content: View>: View {
    var fetchRequest: FetchRequest<T>
    var singers: FetchedResults<T> { fetchRequest.wrappedValue }

    // this is our content closure; we'll call this once for each item in the list
    let content: (T) -> Content

    var body: some View {
        List(fetchRequest.wrappedValue, id: \.self) { singer in
            self.content(singer)
        }
    }

    init(filterKey: String, filterValue: String, @ViewBuilder content: @escaping (T) -> Content) {
        fetchRequest = FetchRequest<T>(entity: T.entity(),
                                       sortDescriptors: [],
                                       predicate: NSPredicate(format: "%K BEGINSWITH %@", filterKey, filterValue))
        self.content = content
    }
}

struct FilteredList_Previews: PreviewProvider {
    static var previews: some View {
        FilteredList(filterKey: "lastName",
                     filterValue: "A") { (singer: Singer) in
            Text("\(singer.wrappedFirstName) \(singer.wrappedLastName)")
        }
    }
}
