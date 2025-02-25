//
//  EditProspectView.swift
//  HotProspects
//
//  Created by Maxim Datskiy on 2/29/24.
//

import SwiftUI
import SwiftData

struct EditProspectView: View {
    @Bindable var prospect: Prospect
    
    var body: some View {
        Form {
            HStack {
                Text("Name:")
                TextField("Name", text: $prospect.name)
                    .textContentType(.name) // allow auto-complete
            }
            
            HStack {
                Text("Email Address")
                TextField("Email", text: $prospect.email)
                    .textContentType(.emailAddress)
            }
        }
        .navigationTitle("Edit Prospect")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Prospect.self, configurations: config)
        let prospect = Prospect(name: "TaylorSwift", email: "taylor@email.com", dateAdded: .now, isContacted: false)
        
        return EditProspectView(prospect: prospect)
            .modelContainer(container)
    } catch {
        return Text("Failed to create container: \(error.localizedDescription)")
    }
}
