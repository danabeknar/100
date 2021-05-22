//
//  NameAlertView.swift
//  Milestone1315
//
//  Created by Beknar Danabek on 22.05.21.
//

import SwiftUI

struct NameAlertView: View {
    @Binding var name: String
    var onDismiss: () -> Void
    
    var body: some View {
        ZStack() {
            Color.gray
                .edgesIgnoringSafeArea(.all)
            VStack {
                Text("Please enter a name below")
                    .padding(.bottom)
                TextField("Name", text: $name)
                    .padding(.bottom)
                Button("Save", action: onDismiss)
            }
            .padding()
            .frame(width: 300, height: 180,alignment: .center)
            .background(Color.white)
            .cornerRadius(20).shadow(radius: 20)
        }
    }
}

struct NameAlertView_Previews: PreviewProvider {
    static var previews: some View {
        NameAlertView(name: .constant("test"), onDismiss: {})
    }
}
