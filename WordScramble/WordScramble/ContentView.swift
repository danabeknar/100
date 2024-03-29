//
//  ContentView.swift
//  WordScramble
//
//  Created by Beknar Danabek on 6/25/20.
//  Copyright © 2020 Beknar Danabek. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var usedWords = ["test","asd","qwe","zxc","we","qwe","f","tasest", "gas", "treq", "fgqw", "q", "a", "x", "e", "r", "t", "y", "u"]
    @State private var rootWord = ""
    @State private var newWord = ""
    
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingError = false
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Enter your word", text: $newWord, onCommit: addNewWord)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .autocapitalization(.none)
                
                List(usedWords, id: \.self) { word in
                    GeometryReader { geo in
                        HStack {
                            Image(systemName: "\(word.count).circle")
                                .foregroundColor(colorForUsedWord(word, geo: geo))
                            Text(word)
                        }
                        .accessibilityElement(children: .ignore)
                        .accessibility(label: Text("\(word), \(word.count) letters"))
                        .offset(x: offsetForUsedWord(word, geo: geo))
                    }
                }
                
                Text("Your score: \(usedWords.count)")
            }
            .navigationBarTitle(rootWord)
            .navigationBarItems(leading: Button("Restart", action: startGame))
            .onAppear(perform: startGame)
            .alert(isPresented: $showingError) {
                Alert(title: Text(errorTitle), message: Text(errorMessage), dismissButton: .default(Text("Ok")))
            }
        }
    }
    
    func offsetForUsedWord(_ word: String, geo: GeometryProxy) -> CGFloat {
        let index = CGFloat(usedWords.firstIndex(of: word)!)
        
        if index > 10 {
            return index * 2 + geo.frame(in: .global).minX
        } else {
            return geo.frame(in: .local).minX
        }
    }
    
    func colorForUsedWord(_ word: String, geo: GeometryProxy) -> Color {
        let index = Double(usedWords.firstIndex(of: word)!)
        let minY = Double(geo.frame(in: .local).minY)
        let maxY = Double(geo.frame(in: .local).maxY)
        
        return Color(hue: minY/maxY + index/Double(usedWords.count),
                     saturation: 0.9,
                     brightness: 0.9)
    }
    
    func startGame() {
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            if let startWords = try? String(contentsOf: startWordsURL) {
                let allWords = startWords.components(separatedBy: "\n")
                rootWord = allWords.randomElement() ?? "silkworm"
                
                return
            }
        }
        
          fatalError("Could not load start.txt from bundle.")
    }
    
    func addNewWord() {
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard answer.count > 0 else {
            return
        }
        
        guard isOriginal(word: answer) else {
            wordError(title: "Word used already", message: "Be more original")
               return
        }
        
        guard isPossible(word: answer) else {
            wordError(title: "Word not recognized", message: "You can't just make them up, you know!")
               return
        }
        
        guard isReal(word: answer) else {
            wordError(title: "Word not possible", message: "That isn't a real word.")
            return
        }
        
        usedWords.insert(answer, at: 0)
        newWord = ""
    }
    
    func isOriginal(word: String) -> Bool {
        !usedWords.contains(word)
    }
    
    func isPossible(word: String) -> Bool {
        var tempWord = rootWord
        
        for letter in word {
            if let pos = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: pos)
            } else {
                return false
            }
        }
        
        return true
    }
    
    func isReal(word: String) -> Bool {
        if word.count < 4 {
            return false
        }
        
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        
        return misspelledRange.location == NSNotFound
    }
    
    func wordError(title: String, message: String) {
        errorTitle = title
        errorMessage = message
        showingError = true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
