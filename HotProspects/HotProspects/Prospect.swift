//
//  Prospect.swift
//  HotProspects
//
//  Created by Beknar Danabek on 22.05.21.
//

import Foundation

class Prospect: Identifiable, Codable {
    var id = UUID()
    var name = "Anonymous"
    var emailAddress = ""
    fileprivate(set) var isContacted = false
}

class Prospects: ObservableObject {
    @Published private(set) var people: [Prospect]
    static let saveKey = "SavedData"
    
    init() {
        let filename = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent(Self.saveKey)

        do {
            let data = try Data(contentsOf: filename)
            people = try JSONDecoder().decode([Prospect].self, from: data)
        } catch {
            people = []
        }
    }
    
    func toggle(_ prospect: Prospect) {
        objectWillChange.send()
        prospect.isContacted.toggle()
        save()
    }
    
    func add(_ prospect: Prospect) {
        people.append(prospect)
        save()
    }
    
    private func save() {
        do {
            let filename = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent(Self.saveKey)
            let data = try JSONEncoder().encode(people)
            try data.write(to: filename, options: [.atomicWrite, .completeFileProtection])
        } catch {
            print("Unable to save data.")
        }
    }
}
