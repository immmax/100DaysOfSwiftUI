//
//  UserDetailsView.swift
//  FriendFace
//
//  Created by Maxim Datskiy on 2/15/25.
//

import SwiftUI

struct UserDetailsView: View {
    let user: User
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            VStack {
                HStack(spacing: 15) {
                    Image(systemName: "person.circle")
                        .resizable()
                        .frame(width: 80, height: 80)
                        .overlay(alignment: .bottomTrailing) {
                            Circle()
                                .frame(width: 20, height: 20)
                                .foregroundStyle(user.isActive ? .green : .pink)
                                .offset(x: -5, y: -5)
                        }
                    VStack(alignment: .leading, spacing: 10) {
                        Text(user.name)
                            .fontWeight(.black)
                        
                        Text("Company: \(user.company)")
                            .foregroundStyle(.secondary)
                    }
                }
                
                Text("Since \(user.registered, format: .dateTime.month().day().year()) | \(user.friends.count) friends")
                    .foregroundStyle(.secondary)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
            .overlay {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(lineWidth: 1)
                    .fill(.gray.opacity(0.7))
            }
            
            Text("TAGS: \(user.tags.joined(separator: ", "))")
                .foregroundStyle(.secondary)
            
            Section {
                List(user.friends) { friend in
                    Text(friend.name)
                        .listRowSeparator(.hidden)
                }
                .listStyle(.plain)
                .scrollBounceBehavior(.basedOnSize)
            } header: {
                Text("FRIENDS")
                    .bold()
                    .foregroundStyle(.secondary)
            }
        }
        .frame(maxWidth: .infinity)
        .padding()
        .navigationTitle("User Info")
        .navigationBarTitleDisplayMode(.inline)
    }
}

//#Preview {
//    UserDetailsView(user: MockData.sampleUser)
//}
//
//struct MockData {
//    static let sampleUser = User(
//        id: "1",
//        isActive: false,
//        name: "Max Datskiy",
//        age: 25,
//        company: "IMD",
//        email: "max@email.com",
//        address: "Seattle. WA",
//        about: "Passionate iOS Developer",
//        registered: .now,
//        tags: ["iOS", "Swift", "SwiftUI", "Xcode", "Git"],
//        friends: [
//            Friend(id: "1", name: "Michael Scott"),
//            Friend(id: "2", name: "Dwight Shrut"),
//            Friend(id: "3", name: "Pam"),
//            Friend(id: "5", name: "Jim"),
//            Friend(id: "5", name: "Kevin"),
//            Friend(id: "6", name: "Ryan")
//        ]
//    )
//}
