//
//  UsersView.swift
//  FriendFace
//
//  Created by Maxim Datskiy on 2/15/25.
//

import SwiftUI

struct UsersView: View {
    @State private var users = [User]()
    
    var body: some View {
            if users.isEmpty {
                ContentUnavailableView {
                    ProgressView()
                } description: {
                    Text("We're trying do download users data")
                }
                .task {
                    await loadData()
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
        guard let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json") else {
            print("Invalid URL")
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            if let decodedResponse = try? decoder.decode([User].self, from: data) {
                users = decodedResponse
            }
        } catch {
            print("Invalid Data: \(error.localizedDescription)")
        }
    }
}

#Preview {
    UsersView()
}
