//
//  EditView.swift
//  BucketList
//
//  Created by Maxim Datskiy on 10/11/23.
//

import SwiftUI

struct EditView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel = ViewModel()
    var location: Location
    var onSave: (Location) -> Void
    
    @State private var pages = [Page]()
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Place Name", text: $viewModel.name)
                    TextField("Description", text: $viewModel.description)
                }
                
                Section("Nearby...") {
                    switch viewModel.loadingState {
                    case .loading:
                        Text("Loading...")
                    case .loaded:
                        ForEach(pages, id: \.pageid) { page in
                            /*@START_MENU_TOKEN@*/Text(page.title)/*@END_MENU_TOKEN@*/
                                .font(.headline)
                            + Text(": ")
                            + Text(page.description)
                                .italic()
                        }
                    case .failed:
                        Text("Pleast try again later")
                    }
                }
            }
            .navigationTitle("Place Details")
            .toolbar {
                Button("Save") {
                    var newLocation = location
                    newLocation.id = UUID()
                    newLocation.name = viewModel.name
                    newLocation.description = viewModel.description
                    
                    onSave(newLocation)
                    dismiss()
                }
            }
            .task {
                await fetchnearbyPlaces()
            }
        }
    }
    
    func fetchnearbyPlaces() async {
        let urlString = "https://en.wikipedia.org/w/api.php?ggscoord=\(location.coordinate.latitude)%7C\(location.coordinate.longitude)&action=query&prop=coordinates%7Cpageimages%7Cpageterms&colimit=50&piprop=thumbnail&pithumbsize=500&pilimit=50&wbptterms=description&generator=geosearch&ggsradius=10000&ggslimit=50&format=json"
        
        guard let url = URL(string: urlString) else {
            print("Bad URL: \(urlString)")
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let items = try JSONDecoder().decode(Result.self, from: data)
            pages = items.query.pages.values.sorted()
            viewModel.loadingState = .loaded
        } catch {
            viewModel.loadingState = .failed
        }
    }
}

#Preview {
    EditView(location: Location.example) { _ in }
}
