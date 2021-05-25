//
//  ContentView.swift
//  Milestone1618
//
//  Created by Beknar Danabek on 25.05.21.
//

import SwiftUI

struct ContentView: View {
    @StateObject var store =  DicesStore()
    
    var body: some View {
        TabView {
            DiceView()
                .tabItem {
                    Label("Dice", systemImage: "heart")
                }
                .environmentObject(store)
            
            HistoryView()
                .tabItem {
                    Label("History", systemImage: "tray.2")
                }
                .environmentObject(store)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
