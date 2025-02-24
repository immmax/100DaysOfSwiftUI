//
//  ContactDetailsView.swift
//  FaceRecall-2025
//
//  Created by Maxim Datskiy on 2/22/25.
//

import PhotosUI
import SwiftData
import SwiftUI

struct ContactDetailsView: View {
    
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var modelContext
    
    @State private var selectedItem: PhotosPickerItem?
    @State private var contactImage: Image?
    
    @Bindable var contact: Contact
    
    var body: some View {
        VStack(spacing: 10) {
            TextField("Enter name", text: $contact.name)
                .textFieldStyle(.roundedBorder)
                .font(.title2).bold()
                .multilineTextAlignment(.center)
                .frame(height: 44)
                .padding()
            
            if let contactImage {
                contactImage
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity)
                .clipShape(.rect(cornerRadius: 10))
                .padding()
                .overlay(alignment: .bottomTrailing) {
                    PhotosPicker(selection: $selectedItem,
                                 matching: .all(of: [.images, .not(.screenshots)])) {
                        Image(systemName: "slider.horizontal.3")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30, height: 30)
                            .padding()
                            .background( Circle().foregroundStyle(.ultraThickMaterial) )
                            .padding()
                            .offset(x: -10, y: -10)
                    }
                }
            }
        } 
        .frame(maxHeight: .infinity, alignment: .top)
        .onChange(of: selectedItem) {
            Task {
                guard let imageData = try await selectedItem?.loadTransferable(type: Data.self) else { return }
                contact.photo = imageData
                try modelContext.save()
                guard let inputImage = UIImage(data: imageData) else { return }
                contactImage = Image(uiImage: inputImage)
            }
        }
        .task {
            Task {
                let inputImage = UIImage(data: contact.photo!)
                contactImage = Image(uiImage: inputImage!)
            }
        }
    }
}

//#Preview {
//    ContactDetailsView()
//}
