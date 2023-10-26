//
//  ProfileView.swift
//  Face Recall
//
//  Created by Maxim Datskiy on 10/25/23.
//

import SwiftUI

struct ProfileView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var contacts: FetchedResults<Contact>
    
    @State private var showingAddView = false
    
    var body: some View {
        NavigationStack {
            Form {
                Image(systemName: "sun.min")
                    .resizable()
                    .scaledToFit()
                    .clipShape(Circle())
                    .frame(width: 150, height: 150)
                    .frame(maxWidth: .infinity, alignment: .center)
                
                Text("My profile")
                    .frame(maxWidth: .infinity, alignment: .center)
                
                
                Section("^[Contacts: \(contacts.count) people](inflect: true)") {
                    List {
                        ForEach(contacts) { contact in
                            ContactItemView(contact: contact)
                        }
                        .onDelete(perform: { indexSet in
                            print("deleted")
                            
                            if moc.hasChanges {
                                try? moc.save()
                            }
                        })
                    }
                }
            }
            .toolbar {
                Button() {
                    showingAddView = true
                } label: {
                    Image(systemName: "person.crop.circle.badge.plus")
                }
            }
            .sheet(isPresented: $showingAddView) {
                AddContactView()
            }
            .navigationTitle("Face Recall")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    ProfileView()
}
