//
//  AddContactView.swift
//  FaceRecall-2025
//
//  Created by Maxim Datskiy on 2/22/25.
//

import CoreLocation
import MapKit
import PhotosUI
import SwiftUI

struct AddContactView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var modelContext
    
    @State private var newContactImage: Image?
    @State private var newContactName: String = ""
    
    var selectedItem: PhotosPickerItem
    var location: CLLocationCoordinate2D
    
    var mapRegion = MapCameraPosition.region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 50, longitude: 0),
            span: MKCoordinateSpan(latitudeDelta: 25, longitudeDelta: 25)
        )
    )
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 10) {
                HStack {
                    if let newContactImage {
                        newContactImage
                            .resizable()
                            .scaledToFill()
                            .frame(width: 200, height: 200)
                            .clipShape(.rect(cornerRadius: 10))
                    }
                }
                
                TextField("Enter name", text: $newContactName)
                    .textFieldStyle(.roundedBorder)
                    .font(.title2).bold()
                    .multilineTextAlignment(.center)
                    .frame(height: 44)
                    .padding()
            }
            .frame(maxHeight: .infinity, alignment: .top)
            .navigationTitle("New Contact")
            .task {
                Task {
                    guard let imageData = try await selectedItem.loadTransferable(type: Data.self) else { return }
                    guard let inputImage = UIImage(data: imageData) else { return }
                    newContactImage = Image(uiImage: inputImage)
                }
            }
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        addContact()
                        dismiss()
                    }
                    .disabled( newContactName.isEmpty )
                }
            }
        }
    }
    
    func addContact() {
        Task {
            guard let imageData = try await selectedItem.loadTransferable(type: Data.self) else { return }
            guard let location else {
                print("Location in nil")
                return
            }
            let newContact = Contact(name: newContactName, location: location, photo: imageData)
            modelContext.insert(newContact)
        }
    }
}

//#Preview {
//    AddContactView(selectedItem: ???)
//}
