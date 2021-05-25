//
//  HistoryView.swift
//  Milestone1618
//
//  Created by Beknar Danabek on 25.05.21.
//

import SwiftUI

struct HistoryView: View {
    @EnvironmentObject private var store: DicesStore
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(store.dices, id: \.self) { dice in
                        Text(dice)
                    }
                }
            }
            .navigationTitle("History")
        }
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView()
    }
}
