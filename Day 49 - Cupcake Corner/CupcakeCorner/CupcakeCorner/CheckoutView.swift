//
//  CheckoutView.swift
//  CupcakeCorner
//
//  Created by Maxim Datskiy on 7/12/23.
//

import SwiftUI

struct CheckoutView: View {
    @Bindable var order: Order
    
    @State private var confirmationTitle = ""
    @State private var confirmationMessage = ""
    @State private var showingConfirmation = false
    
    var body: some View {
        ScrollView {
            VStack {
                AsyncImage(url: URL(string: "https://hws.dev/img/cupcakes@3x.jpg"),
                           scale: 3) { phase in
                    if let image = phase.image {
                        image
                            .resizable()
                            .scaledToFit()
                    } else if phase.error != nil {
                        Text("Error loading image")
                    } else {
                        ProgressView()
                    }
                }
                .frame(height: 233)
                .accessibilityHidden(true)
                
                Text("Your total is \(order.cost, format: .currency(code: "USD"))")
                    .font(.title)
                
                Button("Place Order") {
                    Task {
                        await placeOrder()
                    }
                }
                .padding()
                .buttonStyle(.borderedProminent)
            }
        }
        .navigationTitle("Check out")
        .navigationBarTitleDisplayMode(.inline)
        .scrollBounceBehavior(.basedOnSize)
        .alert(confirmationTitle, isPresented: $showingConfirmation) {
            Button("Ok") { }
        } message: {
            Text(confirmationMessage)
        }
    }
    
    func placeOrder() async {
        guard let encoded = try? JSONEncoder().encode(order) else {
            print("Failed to encode order")
            return
        }
        
        let url = URL(string: "https://reqres.in/api/cupcakes")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
        do {
            let (data, _) = try await URLSession.shared.upload(for: request, from: encoded)
            
            //handle the result
            let decodedOrder = try JSONDecoder().decode(Order.self, from: data)
            confirmationTitle = "Thank you!"
            confirmationMessage = "Your order for \(decodedOrder.quantity)x  \(Order.types[decodedOrder.type].lowercased()) cupcakes is on its way"
            
        } catch {
            print("Checkout failed.")
            confirmationTitle = "Oops!"
            confirmationMessage = "Your request failed :(\nTry again!"
        }
        
        showingConfirmation = true
    }
}

#Preview {
    NavigationStack {
        CheckoutView(order: Order())
    }
}
