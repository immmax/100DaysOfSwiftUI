//
//  ContentView.swift
//  BucketList
//
//  Created by Maxim Datskiy on 9/20/23.
//

import LocalAuthentication
import SwiftUI

struct ContentView: View {
    @State private var isUnlocked = false
    
    var body: some View {
        VStack {
            if isUnlocked {
                Text("Unlocked")
            } else {
                Text("Locked")
            }
            Button("Use Face ID to Unlock", action: authenticate)
                .buttonStyle(.borderedProminent)
                .padding()
            Button() {
                isUnlocked = false
            } label: {
                Image(systemName: "lock.fill")
            }
                .tint(.red)
                .padding()
        }
//        .onAppear(perform: authenticate)
    }
    
    func authenticate() {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "We need to unlock your data"
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics,
                                   localizedReason: reason) { success, autenticationError in
                if success {
                    // authenticated succesfully
                    isUnlocked = true
                } else {
                    // there was a problem
                    
                }
            }
        } else {
            // no biometrics
            
        }
    }
}

#Preview {
    ContentView()
}
