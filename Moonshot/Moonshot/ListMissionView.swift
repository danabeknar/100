//
//  ListMissionView.swift
//  Moonshot
//
//  Created by Beknar Danabek on 21.05.21.
//  Copyright © 2021 Beknar Danabek. All rights reserved.
//

import SwiftUI

struct ListMissionView: View {
    var mission: Mission
    @Binding var isDatePresented: Bool
    let astronauts: [Astronaut]
    private let accessibleMission: AccessibleMission
    
    init(mission: Mission, isDatePresented: Binding<Bool>, astronauts: [Astronaut]) {
        self.mission = mission
        self._isDatePresented = isDatePresented
        self.astronauts = astronauts
        accessibleMission = AccessibleMission(mission: mission)
    }

    var body: some View {
        NavigationLink(destination: MissionView(mission: mission, astronauts: astronauts)) {

        }
    }
}

struct ListMissionView_Previews: PreviewProvider {
    static var previews: some View {
        ListMissionView(mission: Mission(id: 1, launchDate: Date(), crew: [], description: "test"),
                        isDatePresented: .constant(false),
                        astronauts: [])
    }
}
