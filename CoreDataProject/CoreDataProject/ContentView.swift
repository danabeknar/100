//
//  ContentView.swift
//  CoreDataProject
//
//  Created by Beknar Danabek on 9/27/20.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc

    var body: some View {
        Button("Save") {
            if moc.hasChanges {
                try? moc.save()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
