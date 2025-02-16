//
//  ContentView.swift
//  FriendFace
//
//  Created by Maxim Datskiy on 2/15/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            UsersView()
                .navigationTitle("Friends Face")
        }
    }
}

#Preview {
    ContentView()
}
