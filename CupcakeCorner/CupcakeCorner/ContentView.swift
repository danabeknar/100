//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Beknar Danabek on 9/13/20.
//  Copyright © 2020 Beknar Danabek. All rights reserved.
//

import SwiftUI

class User: ObservableObject, Codable {
    @Published var name = "Beknar"
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
    }
    
    enum CodingKeys: CodingKey {
        case name
    }
}

struct ContentView: View {
    var body: some View {
        Text("Hello, World!")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
