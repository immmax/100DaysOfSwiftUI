//
//  ContentView.swift
//  HotProspects
//
//  Created by Maxim Datskiy on 10/26/23.
//

import SwiftUI

@MainActor class User: ObservableObject {
    @Published var name = "Taylor Swift"
}

struct EditView: View {
    @EnvironmentObject var user: User
    
    var body: some View {
        TextField("Name", text: $user.name)
    }
}

struct DisplayView: View {
    @EnvironmentObject var user: User
    
    var body: some View {
        Text(user.name)
    }
}

struct ContentView: View {
    @StateObject var user = User()
    
    var body: some View {
        Form {
            VStack(spacing: 20) {
                EditView()
                    
                DisplayView()
            }
            .environmentObject(user)
            .padding()
        }
    }
}

#Preview {
    ContentView()
}
