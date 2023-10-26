//
//  ContactItemView.swift
//  Face Recall
//
//  Created by Maxim Datskiy on 10/25/23.
//

import SwiftUI

struct ContactItemView: View {
    var contact: Contact
    
    var body: some View {
        NavigationLink(destination: ContactView(contact: contact),
                       label: {
            HStack {
//                Image(URL(file))
                Text(contact.name ?? "unknown name")
            }
        })
    }
}

//#Preview {
//    ContactItemView()
//}
