//
//  SignUpView.swift
//  Face Recall
//
//  Created by Maxim Datskiy on 10/25/23.
//

import SwiftUI
import LocalAuthentication


struct SignUpView: View {
    @Binding var isAuthenticate: Bool
//    @State private var isUnlocked = false
    
    
    var body: some View {
        Button("Sign In", action: authenticate)
            .buttonStyle(.borderedProminent)
            .padding()
    }
    
    func authenticate() {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "We need to unlock your data"
            
            context.evaluatePolicy(
                .deviceOwnerAuthenticationWithBiometrics,
                localizedReason: reason
            ) { success, autenticationError in
                if success {
                    // authenticated succesfully
                    isAuthenticate = true
                } else {
                    // there was a problem
                }
            }
        } else {
            // no biometrics
        }
    }
}

//#Preview {
//    @State var isAuthenticate = false
//    
//    SignUpView(isAuthenticate: $isAuthenticate)
//}
