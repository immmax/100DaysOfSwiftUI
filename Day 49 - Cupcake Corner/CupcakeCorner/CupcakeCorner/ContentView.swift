//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Maxim Datskiy on 7/5/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var order = Order()
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("Select your cake type", selection: $order.details.type) {
                        ForEach(OrderDetails.types.indices) {
                            Text(OrderDetails.types[$0])
                        }
                    }
                    
                    Stepper("Number of cakes: \(order.details.quantity)", value: $order.details.quantity, in: 3...20)
                }
                
                Section {
                    Toggle("Any special requests:", isOn: $order.details.specialRequestEnable.animation())
                    
                    if order.details.specialRequestEnable {
                        Toggle("Add extra frosting", isOn: $order.details.extraFrosting)
                        Toggle("Add extra sprinkles", isOn: $order.details.addSprinkles)
                    }
                }
                
                Section {
                    NavigationLink {
                        AddressView(order: Order())
                    } label: {
                        Text("Delivery details")
                    }
                }
            }
            .navigationTitle("Cupcake Corner")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
