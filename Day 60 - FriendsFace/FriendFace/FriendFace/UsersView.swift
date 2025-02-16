//
//  UsersView.swift
//  FriendFace
//
//  Created by Maxim Datskiy on 2/15/25.
//

import SwiftData
import SwiftUI

struct UsersView: View {
    @Environment(\.modelContext) var modelContext
    @Query var users: [User]
    
    var body: some View {
            if users.isEmpty {
                ContentUnavailableView {
                    ProgressView()
                } description: {
                    Text("We're trying do download users data")
                }
                .task {
//                    if users.isEmpty {
                        await loadData()
//                    }
                }
            } else {
                List(users) { user in
                    NavigationLink {
                        UserDetailsView(user: user)
                    } label: {
                        HStack {
                            Text(user.name)
                                
                            Spacer()
                            
                            Circle()
                                .frame(width: 10, height: 10)
                                .foregroundStyle(user.isActive ? .green : .pink)
                        }
                    }
                }
            }
    }
    
    func loadData() async  {
        print("I'M INSIDE OF THE FUNCTION, LOL")
        guard let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json") else {
            print("Invalid URL")
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
        
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            
            if let decodedResponse = try? decoder.decode([User].self, from: data) {
                for user in decodedResponse {
                    modelContext.insert(user)
//                    try modelContext.save()
                }
                
//                decodedResponse.map { user in
//                    modelContext.insert(user)
//                    try? modelContext.save()
//                }
            }
        } catch {
            print("Invalid Data: \(error.localizedDescription)")
        }
    }
}

#Preview {
    UsersView()
}
