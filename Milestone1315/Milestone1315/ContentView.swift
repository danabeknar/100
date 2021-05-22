//
//  ContentView.swift
//  Milestone1315
//
//  Created by Beknar Danabek on 22.05.21.
//

import SwiftUI

struct ContentView: View {
    @State private var showingPicker = false
    @State private var showingPersonAddDetails = false
    
    @State private var image: UIImage?
    @State private var name = ""
    
    @State private var persons: [Person] = []
    @State private var currentPerson: Person?
    
    private let path = "SavedPersons"
    
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
                
                if showingPersonAddDetails {
                    PersonAlertView(
                        person: currentPerson!,
                        onDismiss: {
                            showingPersonAddDetails.toggle()
                            addPerson()
                        })
                }
            }
            .onAppear(perform: loadData)
            .navigationTitle("Persons")
            .navigationBarItems(trailing:
                Button("Select a picture") {
                    showingPicker.toggle()
            })
        }
        .sheet(isPresented: $showingPicker, onDismiss: askUserToNamePhotoIfNeeded) {
            ImagePickerView(image: $image)
        }
    }
    
    private func askUserToNamePhotoIfNeeded() {
        guard let image = image else { return }
        
        currentPerson = Person()
        currentPerson?.image = image
        showingPersonAddDetails = true
    }
    
    private func addPerson() {
        guard let currentPerson = currentPerson else { return }
        
        persons.append(currentPerson)
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
