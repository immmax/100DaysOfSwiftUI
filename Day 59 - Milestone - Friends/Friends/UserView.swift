//
//  UserView.swift
//  Friends
//
//  Created by Maxim Datskiy on 8/14/23.
//

import SwiftUI

struct UserView: View {
    @State private var user: CachedUser
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
                        Text("REGISTERED: \(user.wrappedRegistered)")
                        Text("ADDRESS: \(user.wrappedAddress)")
                        Text("EMAIL: \(user.wrappedEmail)")
                        Text("COMPANY: \(user.wrappedCompany)")
                        Text("AGE: \(user.age)")
                        Text("ABOUT: \(user.wrappedAbout)")
                        HStack {
                            ForEach(user.tagsArray, id: \.self) { tag in
                                Text(tag.wrappedTagName)
                            }
                        }
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
                        ForEach(user.friendArray) { friend in
                            Text(friend.wrappedName)
                        }
                    }
                }
            }
            .navigationTitle(user.wrappedName)
        }
    }
    
    init(user: CachedUser) {
        self.user = user
    }
}
