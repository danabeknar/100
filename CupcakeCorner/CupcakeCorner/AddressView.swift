//
//  AddressView.swift
//  CupcakeCorner
//
//  Created by Beknar Danabek on 9/13/20.
//  Copyright © 2020 Beknar Danabek. All rights reserved.
//

import SwiftUI

struct AddressView: View {
    @ObservedObject var orderContainer: OrderContainer
    
    var body: some View {
        Form {
            Section {
                TextField("Name", text: $orderContainer.order.name)
                TextField("Street Address", text: $orderContainer.order.streetAddress)
                TextField("City", text: $orderContainer.order.city)
                TextField("Zip", text: $orderContainer.order.zip)
            }
            
            Section {
                NavigationLink(destination: CheckoutView(orderContainer: orderContainer)) {
                    Text("Check out")
                }.disabled(orderContainer.order.hasValidAddress == false)
            }
        }
        .navigationBarTitle("Delivery details", displayMode: .inline)
    }
}

struct AddressView_Previews: PreviewProvider {
    static var previews: some View {
        AddressView(orderContainer: OrderContainer())
    }
}
