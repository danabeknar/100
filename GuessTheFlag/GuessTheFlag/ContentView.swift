//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Beknar Danabek on 6/18/20.
//  Copyright © 2020 Beknar Danabek. All rights reserved.
//

import SwiftUI

struct FlagImage: View {
    let imageName: String
    
    var body: some View {
        Image(imageName)
            .renderingMode(.original)
            .clipShape(Capsule())
            .overlay(Capsule().stroke(Color.white, lineWidth: 1))
            .shadow(color: .black, radius: 2)
    }
}

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland",
                                    "Italy", "Nigeria", "Poland", "Russia",
                                    "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var scoreSubtitle = ""
    @State private var score = 0
    
    @State private var animationAmount = 0.0
    @State private var correctAnimatingFlags = [false, false, false]
    @State private var wrongAnimatingFlags = [false, false, false]
    @State private var flagsOpacity = [1.0, 1.0, 1.0]
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.blue, .black]),
                           startPoint: .top,
                           endPoint: .bottom).edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 30) {
                VStack {
                    Text("Tap the flag of")
                        .foregroundColor(.white)
                    Text(countries[correctAnswer])
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .fontWeight(.black)
                }
                
                ForEach (0 ..< 3) { number in
                    Button(action: {
                        self.flagTapped(number: number)
                        if self.correctAnimatingFlags[number] || self.wrongAnimatingFlags[number] {
                            withAnimation {
                                self.animationAmount += 360
                            }
                        }
                    }) {
                        FlagImage(imageName: self.countries[number])
                    }
                        .rotation3DEffect(.degrees(self.correctAnimatingFlags[number] ? self.animationAmount : 0.0),
                                      axis: (x: 0, y: 1, z: 0))
                        .rotation3DEffect(.degrees(self.wrongAnimatingFlags[number] ? self.animationAmount : 0.0),
                        axis: (x: 0, y: 0, z: 1))
                        .opacity(self.flagsOpacity[number])
                }
                Text("Your score is \(score)")
                    .foregroundColor(.white)
                    .font(.headline)
                
                Spacer()
            }
        }
        .alert(isPresented: $showingScore) {
            Alert(title: Text(scoreTitle),
                  message: Text(scoreSubtitle),
                  dismissButton: .default(Text("Continue")) {
                    self.askQuestion()
                })
        }
    }
    
    func flagTapped(number: Int) {
        let answeredRight = number == correctAnswer
        
        modifyScore(answeredRight: answeredRight)
        modifyTitle(answeredRight: answeredRight)
        modifySubtitle(answeredRight: answeredRight, number: number)
        modifyCorrectAnimating(answeredRight: answeredRight, number: number)
        modifyWrongAnimating(answeredRight: answeredRight, number: number)
        modifyOpacity(number: number)
        
        showingScore = true
    }
    
    func modifyTitle(answeredRight: Bool) {
        scoreTitle = answeredRight ? "Correct" : "Wrong"
    }
    
    func modifySubtitle(answeredRight: Bool, number: Int) {
        if answeredRight {
            scoreSubtitle = "Your score is \(score)"
        } else {
            scoreSubtitle = "Wrong! That's a flag of the \(countries[number])"
        }
    }
    
    func modifyScore(answeredRight: Bool) {
        score += answeredRight ? 1 : -1
        score = score < 0 ? 0 : score
    }
    
    func modifyCorrectAnimating(answeredRight: Bool, number: Int) {
        correctAnimatingFlags[number] = answeredRight
    }
    
    func modifyOpacity(number: Int) {
        flagsOpacity = flagsOpacity.enumerated().map { index, _ in
            return index != number ? 0.25 : 1
        }
    }
    
    func modifyWrongAnimating(answeredRight: Bool, number: Int) {
        guard !answeredRight else { return }
        
        wrongAnimatingFlags[number] = true
    }
    
    func askQuestion() {
        flagsOpacity = [1.0, 1.0, 1.0]
        correctAnimatingFlags = [false, false, false]
        wrongAnimatingFlags = [false, false, false]
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
