//
//  ContentView.swift
//  Friends
//
//  Created by Maxim Datskiy on 8/14/23.
//

import SwiftUI

struct ContentView: View {
    @State private var users = [User]()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(users) { user in
                    NavigationLink {
                        VStack {
                            DetailUserView(user: user)
//                                .padding()
                        }
//                        .padding(.vertical)
                    } label: {
                        HStack(alignment: .center) {
                            Image(systemName: user.isActive ? "checkmark.circle.fill" : "x.circle.fill")
                                .foregroundColor(user.isActive ? Color.green : Color.pink)
                            VStack(alignment: .leading) {
                                Text(user.name)
                                    .font(.headline)
                                Text(user.company)
                                    .font(.subheadline)
                            }
                            .foregroundColor(.primary)
                        }
//                        .padding(.vertical)
                    }
                }
            }
            .task {
                await loadData()
            }
            .navigationTitle("Friends")
        }
    }
    
    func loadData() async {
        if users.isEmpty {
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
                print("Invalid data")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
