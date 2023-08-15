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
            List(users, id: \.id) { user in
                HStack(alignment: .center) {
                    Image(systemName: user.isActive ? "checkmark.circle.fill" : "x.circle.fill")
                        .foregroundColor(user.isActive ? Color.green : Color.pink)
                    Text(user.name)
                        .font(.headline)
                }
            }
            .task {
                await loadData()
            }
            .navigationTitle("Friends")
        }
    }
    
    func loadData() async {
        guard let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json") else {
            print("Invalid URL")
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)

            if let decodedResponse = try? JSONDecoder().decode([User].self, from: data) {
                users = decodedResponse
            }
            
        } catch {
            print("Invalid data")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
