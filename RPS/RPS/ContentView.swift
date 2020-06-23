//
//  ContentView.swift
//  RPS
//
//  Created by Beknar Danabek on 6/23/20.
//  Copyright © 2020 Beknar Danabek. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var game = RockPaperScissors()
    @State private var score = 0
    let moves: [Option] = Option.allCases
    
    @State var currentChoice: Option = Option.allCases.randomElement()!
    @State var shouldWin = Bool.random()
    @State var showingAlert = false
    
    var body: some View {
        NavigationView {
            VStack {
                GoalView(goal: game.goal)
                OptionView(option: game.option)
                    .font(.system(size: 60))
                
                HStack {
                    ForEach(Option.allCases, id: \.self) { option in
                        Button(action: {
                            self.didPressOption(option)
                        }, label: {
                            OptionView(option: option)
                                .font(.largeTitle)
                                .padding()
                        })
                    }
                }
                
                Text("Score: \(score)")
            }
            .navigationBarTitle("RPS")
        }
        .alert(isPresented: $showingAlert) {
            Alert(title: Text("Game over"), message: Text("Your score is 10"), dismissButton: .default(Text("Start again")) {
                self.newGame()
            })
        }
    }
    
    private func newGame() {
        score = 0
        showingAlert = false
        newQuestion()
    }
    
    private func didPressOption(_ option: Option) {
        let win = game.isCorrect(guess: option)
        score += win ? 1 : -1
        
        if score == 10 {
            showingAlert = true
        } else {
            newQuestion()
        }
    }
    
    private func newQuestion() {
        game = RockPaperScissors()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
