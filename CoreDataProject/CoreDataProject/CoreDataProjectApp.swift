//
//  CoreDataProjectApp.swift
//  CoreDataProject
//
//  Created by Beknar Danabek on 3.05.21.
//

import SwiftUI

@main
struct CoreDataProjectApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
