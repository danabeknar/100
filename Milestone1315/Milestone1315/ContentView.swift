//
//  ContentView.swift
//  Milestone1315
//
//  Created by Beknar Danabek on 22.05.21.
//

import SwiftUI

struct ContentView: View {
    @State private var showingPicker = false
    @State private var image: UIImage?
    @State private var showingNamingAlert = false
    @State private var name = ""
    @State private var persons: [Person] = []
    private let path = "SavedPersons"
    
    private var addPersonButton: some View {
        Button("Select a picture") {
            showingPicker.toggle()
        }
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    List {
                        ForEach(persons) { person in
                            NavigationLink(destination: DetailPersonView(person: person)) {
                                PersonView(person: person)
                            }
                        }
                    }
                }
                
                if showingNamingAlert {
                    NameAlertView(name: $name, onDismiss: saveImageAndName)
                }
            }
            .onAppear(perform: loadData)
            .navigationTitle("Persons")
            .navigationBarItems(trailing: addPersonButton)
        }
        .sheet(isPresented: $showingPicker, onDismiss: askUserToNamePhotoIfNeeded) {
            ImagePickerView(image: $image)
        }
    }
    
    private func askUserToNamePhotoIfNeeded() {
        if image == nil { return }
        
        showingNamingAlert = true
    }
    
    private func saveImageAndName() {
        showingNamingAlert = false
        
        guard let image = image, !name.isEmpty else { return }
        let person = Person(name: name, image: image)
        persons.append(person)
        persons.sort()
        saveData()
    }
    
    
    private func loadData() {
        let filename = getDocumentsDirectory().appendingPathComponent(path)
        
        do {
            let data = try Data(contentsOf: filename)
            persons = try JSONDecoder().decode([Person].self, from: data).sorted()
        } catch {
            print("Unable to load saved data.")
        }
    }
    
    private func saveData() {
        DispatchQueue.global(qos: .background).async {
            do {
                let filename = getDocumentsDirectory().appendingPathComponent(path)
                let data = try JSONEncoder().encode(self.persons)
                try data.write(to: filename, options: [.atomicWrite, .completeFileProtection])
            } catch {
                print("Unable to save data.")
            }
        }
    }
    
    private func getDocumentsDirectory() -> URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
