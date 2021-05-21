//
//  AstronautView.swift
//  Moonshot
//
//  Created by Beknar Danabek on 8/31/20.
//  Copyright © 2020 Beknar Danabek. All rights reserved.
//

import SwiftUI

struct AstronautView: View {
    let astronaut: Astronaut
    let missions: [Mission] = Bundle.main.decode("missions.json")
    
    var astronautMissions: [Mission] {
        missions.filter {
            $0.contains(astronaut)
        }
    }
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical) {
                VStack {
                    Image(decorative: self.astronaut.id)
                        .resizable()
                        .scaledToFit()
                        .frame(width: geometry.size.width)
                    
                    Text(self.astronaut.description)
                        .padding()
                        .layoutPriority(1)
                    
                    
                    Text("Missions")
                        .padding(EdgeInsets(top: 5, leading: 20, bottom: 0, trailing: 0))
                        .foregroundColor(Color.gray)
                    List(self.astronautMissions) { mission in
                            Image(decorative: mission.image)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 44, height: 44)
                            
                            VStack(alignment: .leading) {
                                Text(mission.displayName)
                                    .font(.headline)
                                Text(mission.formattedLaunchDate)
                                    .accessibility(label: Text(AccessibleMission(mission: mission).date))
                                
                            }
                        }
                }
            }
        }
        .navigationBarTitle(Text(astronaut.name), displayMode: .inline)
    }
}

struct AstronautView_Previews: PreviewProvider {
    static let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    
    static var previews: some View {
        AstronautView(astronaut: astronauts[0])
    }
}
