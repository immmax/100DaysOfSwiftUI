//
//  ContentView.swift
//  Face Recall
//
//  Created by Maxim Datskiy on 10/18/23.
//

import SwiftUI

enum views {
    case signIn, signUp, profile
}

struct ContentView: View {
    @State private var isAuthenticate = false
    
    var body: some View {
        switch isAuthenticate {
        case false: SignUpView(isAuthenticate: $isAuthenticate)
        case true: ProfileView()
        }
    }
}

#Preview {
    ContentView()
}
