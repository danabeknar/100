//
//  MissionView.swift
//  Moonshot
//
//  Created by Beknar Danabek on 8/30/20.
//  Copyright © 2020 Beknar Danabek. All rights reserved.
//

import SwiftUI

struct MissionView: View {
    struct CrewMember {
        let role: String
        let astronaut: Astronaut
    }
    
    let mission: Mission
    let astronauts: [CrewMember]
    private let accessibleMission: AccessibleMission
    
    init(mission: Mission, astronauts: [Astronaut]) {
        self.mission = mission
        
        var matches = [CrewMember]()
        
        for member in mission.crew {
            if let match = astronauts.first(where: { $0.id == member.name }) {
                matches.append(CrewMember(role: member.role, astronaut: match))
            } else {
                fatalError("Missing \(member)")
            }
        }
        
        self.astronauts = matches
        accessibleMission = AccessibleMission(mission: mission)
    }
    
    var body: some View {
        GeometryReader { geo in
            ScrollView(.vertical) {
                VStack {
                    GeometryReader { imageGeo in
                        Image(decorative: self.mission.image)
                            .resizable()
                            .scaledToFit()
                            .padding(.top)
                            .frame(width: imageGeo.size.width, height: imageGeo.size.height)
                            .scaleEffect(1 - ((geo.safeAreaInsets.top - imageGeo.frame(in: .global).minY) / 700))
                    }
                    
                    Text(self.mission.formattedLaunchDate)
                        .font(.caption)
                        .padding()
                        .accessibility(label: Text(accessibleMission.date))
                    
                    Text(self.mission.description)
                        .padding()
                        .accessibility(label: Text(accessibleMission.description))
                    
                    Text("Astronauts")
                        .hidden()
                        .frame(width: 0, height: 0)
                        .accessibility(label: Text("Astronauts"))
                    
                    ForEach(self.astronauts, id: \.role) { crewMember in
                        NavigationLink(destination: AstronautView(astronaut: crewMember.astronaut)) {
                            HStack {
                                Image(decorative: crewMember.astronaut.id)
                                    .resizable()
                                    .frame(width: 83, height: 60)
                                    .clipShape(Capsule())
                                    .overlay(Capsule().stroke(Color.primary, lineWidth: 1))
                                
                                VStack(alignment: .leading) {
                                    Text(crewMember.astronaut.name)
                                        .font(.headline)
                                    Text(crewMember.role)
                                        .foregroundColor(.secondary)
                                }
                                .accessibilityElement(children: .ignore)
                                .accessibility(label: Text(crewMember.role + crewMember.astronaut.name))
                                
                                Spacer()
                            }
                        }
                        .buttonStyle(PlainButtonStyle())
                        .padding(.horizontal)
                    }
                    
                    Spacer(minLength: 25)
                    
                }
            }
            .navigationBarTitle(Text(self.mission.displayName), displayMode: .inline)
        }
    }
}

struct MissionView_Previews: PreviewProvider {
    static let missions: [Mission] = Bundle.main.decode("missions.json")
    static let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    
    static var previews: some View {
        MissionView(mission: missions[0], astronauts: astronauts)
    }
}
