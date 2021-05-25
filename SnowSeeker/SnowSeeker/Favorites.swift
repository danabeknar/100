//
//  Favorites.swift
//  SnowSeeker
//
//  Created by Beknar Danabek on 26.05.21.
//

import Foundation

class Favorites: ObservableObject {
    private var resorts: Set<String>

    private let saveKey = "Favorites"

    init() {
        if let resorts = UserDefaults.standard.value(forKey: saveKey) as? [String] {
            self.resorts = Set(resorts.map { $0} )
        } else {
            self.resorts = []
        }
    }
    
    func contains(_ resort: Resort) -> Bool {
        resorts.contains(resort.id)
    }

    func add(_ resort: Resort) {
        objectWillChange.send()
        resorts.insert(resort.id)
        save()
    }

    func remove(_ resort: Resort) {
        objectWillChange.send()
        resorts.remove(resort.id)
        save()
    }

    func save() {
        UserDefaults.standard.setValue(Array(resorts), forKey: saveKey)
    }
}
