//
//  ContentView.swift
//  FaceRecall-2025
//
//  Created by Maxim Datskiy on 2/22/25.
//

import CoreLocation
import PhotosUI
import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @Query(sort: [SortDescriptor(\Contact.name)]) var contacts: [Contact]
    
    @State private var selectedItem: PhotosPickerItem?
    @State private var showAddView: Bool = false
    
    let locationFetcher = LocationFetcher()
    @State private var location: CLLocationCoordinate2D?
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(contacts) { contact in
                    NavigationLink {
                        ContactDetailsView(contact: contact)
                    } label: {
                        HStack(spacing: 20) {
                            Image(uiImage: UIImage(data: contact.photo!)!)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 60, height: 60)
                                .clipShape(.circle)
                            
                            Text(contact.name)
                        }
                    }
                    .buttonStyle(.plain)
                }
                .onDelete(perform: deleteContact)
            }
            .listStyle(.plain)
            .listRowSeparator(.hidden)
            .overlay(alignment: .bottomTrailing) {
                PhotosPicker(selection: $selectedItem,
                             matching: .all(of: [.images, .not(.screenshots)])) {
                    Image(systemName: "camera")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30, height: 30)
                        .padding()
                        .background(
                            Circle()
                                .foregroundStyle(.ultraThickMaterial))
                        .padding()
                }
            }
            .navigationTitle("Face Recall")
            .task {
                locationFetcher.start()
            }
            .onChange(of: selectedItem) {
                locationFetcher.start()
                if let location = locationFetcher.lastKnownLocation {
                    self.location = location
                    print("Your location is \(self.location)")
                } else {
                    print("Your location is unknown: \(self.location)")
                }
                showAddView = true
            }
            .navigationDestination(item: $selectedItem) { selection in
                AddContactView(selectedItem: selection, location: location ?? CLLocationCoordinate2D(latitude: 0, longitude: 0))
                    .onDisappear {
                        selectedItem = nil
                    }
            }
        }
    }
    
    func deleteContact(at indexSet: IndexSet) {
        for index in indexSet {
            modelContext.delete(contacts[index])
        }
    }
}

//#Preview {
//    ContentView()
//}
