//
//  ContactView.swift
//  Face Recall
//
//  Created by Maxim Datskiy on 10/19/23.
//

import SwiftUI


struct ContactView: View {
    var contact: Contact
        
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack(spacing: 20) {
                Image(systemName: "person")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
                Text(contact.name ?? "Unknown Name")
                    .font(.title)
            }
            
            Text(contact.about ?? "No detailed description")
            
            Spacer()
        }
        .padding()
    }
}


//#Preview {
//    ContactView()
//}
