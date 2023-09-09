//
//  ContentView.swift
//  Friends
//
//  Created by Maxim Datskiy on 8/14/23.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var cachedUsers: FetchedResults<CachedUser>
    @State private var users = [User]()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(cachedUsers) { user in
                    NavigationLink {
                        VStack {
                            UserView(user: user)
                        }
                    } label: {
                        HStack(alignment: .center) {
                            Image(systemName: user.isActive ? "checkmark.circle.fill" : "x.circle.fill")
                                .foregroundColor(user.isActive ? Color.green : Color.pink)
                            VStack(alignment: .leading) {
                                Text(user.wrappedName)
                                    .font(.headline)
                                Text(user.wrappedCompany)
                                    .font(.subheadline)
                            }
                            .foregroundColor(.primary)
                        }
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
        guard let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json") else {
            print("Invalid URL")
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            guard let users = try? decoder.decode([User].self, from: data) else {
                print("Failed to decode data")
                return
            }
        } catch {
            print("Invalid data")
        }

        updateCache(with: users)
    }
    
    func updateCache(with users: [User]) {
        for jsonUser in users {
            let user = CachedUser(context: moc)
            user.id = jsonUser.id
            user.name = jsonUser.name
            user.about = jsonUser.about
            user.email = jsonUser.email
            user.address = jsonUser.address
            user.company = jsonUser.company
            user.registered = jsonUser.registered
            user.isActive = jsonUser.isActive
            user.age = Int16(jsonUser.age)
//            try? moc.save()
//            user.tags = jsonUser.tags.joined(separator: ",")
//            user.friends = jsonUser.friends
            if moc.hasChanges {
                try? moc.save()
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
