//
//  DetailView.swift
//  Bookworm
//
//  Created by Maxim Datskiy on 7/26/23.
//

import SwiftData
import SwiftUI

struct DetailView: View {
    let book: Book
    
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    @State private var showingDeleteAlert = false
    
    var body: some View {
        ScrollView {
            ZStack(alignment: .bottomTrailing) {
                Image(book.genre)
                    .resizable()
                    .scaledToFit()
                
                Text(book.genre.uppercased())
                    .font(.caption)
                    .fontWeight(.black)
                    .padding(8)
                    .foregroundColor(.white)
                    .background(.black.opacity(0.75))
                    .clipShape(Capsule())
                    .offset(x: -5, y: -5)
            }
            
            VStack(spacing: 8) {
                Text(book.author)
                    .font(.title)
                    .foregroundColor(.secondary)
                
                HStack {
                    RatingView(rating: .constant(Int(book.rating)))
                    
                    Spacer()
                    
                    Text(book.date.formatted(date: .abbreviated, time: .shortened))
                }
            }
            
            Text(book.review)
                .padding()
        }
        .navigationTitle(book.title)
        .navigationBarTitleDisplayMode(.inline)
        .scrollBounceBehavior(.basedOnSize)
        .alert("Delete book?", isPresented: $showingDeleteAlert) {
            Button("Delete", role: .destructive, action: deleteBook)
            Button("Cancel", role: .cancel) {}
        } message: {
            Text("Are you sure?")
        }
        .toolbar {
            Button("Delete this book", systemImage: "trash") {
                showingDeleteAlert = true
            }
        }
    }
    
    func deleteBook() {
        modelContext.delete(book)
        
        try? modelContext.save()
        dismiss()
    }
}

#Preview {
//    do {
//        let config = ModelConfiguration(isStoredInMemoryOnly: true)
//        let container = try ModelContainer(for: Book.self, configuration: config)
//        let example = Book(title: "Installation Guide", author: "Lian Li", rating: 4, genre: "Fantasy", review: "This is a great case, but installation guide might be better", date: .now)
//        
//        return DetailView(book: example)
//            .modelContainer(container)
//    } catch {
//        return Text("Failed to create preview: \(error.localizedDescription)")
//    }
}
