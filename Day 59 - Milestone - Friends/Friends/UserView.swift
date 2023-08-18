//
//  UserView.swift
//  Friends
//
//  Created by Maxim Datskiy on 8/14/23.
//

import SwiftUI

struct UserView: View {
    @State private var user: User
    @State private var showingInfo = false
    @State private var showingFriends = false
    
    var body: some View {
        VStack {
            Group {
                Text(user.isActive ? "Online" : "Offline")
                    .foregroundColor(user.isActive ? Color.green : Color.pink)
            }
            Form {
                Button("Info") {
                    withAnimation{
                        showingInfo.toggle()
                    }
                }
                .buttonStyle(.borderedProminent)
                
                if showingInfo {
                    List {
                        Text("REGISTERED: \(user.registered)")
                        Text("ADDRESS: \(user.address)")
                        Text("EMAIL: \(user.email)")
                        Text("COMPANY: \(user.company)")
                        Text("AGE: \(user.age)")
                        Text("ABOUT: \(user.about)")
                    }
                }
                
                Button("Friends") {
                    withAnimation {
                        showingFriends.toggle()
                    }
                }
                .buttonStyle(.borderedProminent)
                
                if showingFriends {
                    List {
                        ForEach(user.friends) { friend in
                            Text(friend.name)
                        }
                    }
                }
            }
            .navigationTitle(user.name)
        }
    }
    
    init(user: User) {
        self.user = user
    }
}
