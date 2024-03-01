//
//  EditProspectView.swift
//  HotProspects
//
//  Created by Maxim Datskiy on 2/29/24.
//

import SwiftUI
import SwiftData

struct EditProspectView: View {
    @State var prospect: Prospect
    
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
    }
}

//#Preview {
//    EditProspectView(prospect: Prospect(name: "Sasha", email: "sasha@gmail.com", isContacted: false))
//}
