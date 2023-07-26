//
//  AddressView.swift
//  CupcakeCorner
//
//  Created by Maxim Datskiy on 7/12/23.
//

import SwiftUI

struct AddressView: View {
    @ObservedObject var order: Order
    
    var body: some View {
        Form {
            Section {
                TextField("Name", text: $order.details.name)
                TextField("Street Address", text: $order.details.streetAddress)
                TextField("City", text: $order.details.city)
                TextField("Zip", text: $order.details.zip)
            }
            
            Section {
                NavigationLink {
                    CheckoutView(order: order)
                } label: {
                    Text("Check out")
                }
            }
            .disabled(order.details.hasValidAddress == false)
        }
        .navigationTitle("Delivery Detailes")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct AddressView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AddressView(order: Order())
        }
    }
}
