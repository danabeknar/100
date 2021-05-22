//
//  Prospect.swift
//  HotProspects
//
//  Created by Beknar Danabek on 22.05.21.
//

import Foundation

class Prospect: Identifiable, Codable, Comparable {
    var id = UUID()
    var name = "Anonymous"
    var emailAddress = ""
    var addedDate = Date()
    fileprivate(set) var isContacted = false
    
    static func < (lhs: Prospect, rhs: Prospect) -> Bool {
        lhs.addedDate < rhs.addedDate
    }
    
    static func == (lhs: Prospect, rhs: Prospect) -> Bool {
        lhs.addedDate == rhs.addedDate
    }
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
    
    func sortByName() {
        people.sort(by: { $0.name > $1.name })
    }
    
    func sortByDate() {
        people.sort(by: { $0.addedDate > $1.addedDate })
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
