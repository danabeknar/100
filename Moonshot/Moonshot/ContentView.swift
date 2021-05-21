//
//  ContentView.swift
//  Moonshot
//
//  Created by Beknar Danabek on 8/27/20.
//  Copyright © 2020 Beknar Danabek. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    @State private var isDatePresented = true
    
    var body: some View {
        NavigationView {
            List(missions) { mission in
                ListMissionView(mission: mission, isDatePresented: $isDatePresented, astronauts: astronauts)
            }
            .navigationBarTitle("Moonshot")
            .navigationBarItems(trailing:
                Button("Show \(isDatePresented ? "date" : "crew")") {
                    self.isDatePresented.toggle()
                }
            )
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
