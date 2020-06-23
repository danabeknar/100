//
//  OptionView.swift
//  RPS
//
//  Created by Beknar Danabek on 6/23/20.
//  Copyright © 2020 Beknar Danabek. All rights reserved.
//

import SwiftUI

struct OptionView: View {
    var option: Option
    
    var body: some View {
          switch option {
          case .rock:
            return Text("✊")
          case .paper:
              return Text("✋")
          case .scissors:
              return Text("✌️")
          }
      }
}
