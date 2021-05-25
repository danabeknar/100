//
//  DiceView.swift
//  Milestone1618
//
//  Created by Beknar Danabek on 25.05.21.
//

import SwiftUI

let key = "Dices"

struct GrowingButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(8)
            .scaleEffect(configuration.isPressed ? 1.2 : 1)
            .animation(.easeOut(duration: 0.2))
    }
}

struct DiceView: View {
    @State private var result: Int?
    @EnvironmentObject private var store: DicesStore
    
    var body: some View {
        VStack {
            Text("Total rolls: \(store.dices.count)")
                .font(.largeTitle)
                .fontWeight(.black)
                .padding()
                .background(Color.red)
                .cornerRadius(4)
                .foregroundColor(.white)
                .padding(.bottom)
            
            Button("Roll") {
                result = Int.random(in: 0...6)
                store.add(String(result!))
                UINotificationFeedbackGenerator().notificationOccurred(.success)
            }
            .buttonStyle(GrowingButton())
            .padding(.bottom)
            
            if result != nil {
                Text("\(result!)")
                    .font(.largeTitle)
                    .fontWeight(.black)
                    .padding()
                    .background(Color.yellow)
                    .clipShape(Circle())
                    .foregroundColor(.white)
            }
        }
    }
}

struct DiceView_Previews: PreviewProvider {
    static var previews: some View {
        DiceView()
    }
}
