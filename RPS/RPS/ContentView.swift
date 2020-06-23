//
//  ContentView.swift
//  RPS
//
//  Created by Beknar Danabek on 6/23/20.
//  Copyright © 2020 Beknar Danabek. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    let moves: [RPSOption] = RPSOption.allCases
    
    @State var currentChoice: RPSOption = RPSOption.allCases.randomElement()!
    @State var shouldWin = Bool.random()
    @State var score = 0
    @State var showingAlert = false
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Your score: \(score)")
                    .padding(.bottom)
                    
                Text("App's move: \(currentChoice.description)")
                Text("Your should \(shouldWin ? "win" : "lose")")
                
                HStack {
                    ForEach (0..<moves.count) { index in
                        Button(action: {
                            self.didPressOption(self.moves[index])
                        }) {
                            Text("\(self.moves[index].description)")
                        }
                        .padding(30)
                    }
                }
            }
            .navigationBarTitle("RPS")
        }
        .alert(isPresented: $showingAlert) {
            Alert(title: Text("Game over"), message: Text("Your score is 10"), dismissButton: .default(Text("Start again")) {
                self.startAgain()
            })
        }
    }
    
    private func didPressOption(_ option: RPSOption) {
        if currentChoice == .rock {
            if option == .paper {
                score += shouldWin ? +1 : -1
            } else if option == .scissors {
                score += shouldWin ? -1 : +1
            }
        } else if currentChoice == .paper {
            if option == .rock {
                score += shouldWin ? -1 : +1
            } else if option == .scissors {
                score += shouldWin ? +1 : -1
            }
        } else {
            if option == .paper {
                score += shouldWin ? -1 : +1
            } else if option == .rock {
                score += shouldWin ? +1 : -1
            }
        }
        
        if score < 0 {
            score = 0
        }
        
        if score == 2 {
            showingAlert = true
        }
        
        updateState()
    }
    
    private func startAgain() {
        showingAlert = false
        score = 0
        updateState()
    }
    
    private func updateState() {
        shouldWin.toggle()
        currentChoice = RPSOption.allCases.randomElement()!
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
