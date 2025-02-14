//
//  DetailView.swift
//  Bookworm
//
//  Created by Maxim Datskiy on 7/26/23.
//

import SwiftUI

struct DetailView: View {
    let book: Book
    
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    @State private var showingDeleteAlert = false
    
    var body: some View {
        ScrollView {
            ZStack(alignment: .bottomTrailing) {
                Image(book.genre ?? "General")
                    .resizable()
                    .scaledToFit()
                
                Text(book.genre?.uppercased() ?? "GENERAL")
                    .font(.caption)
                    .fontWeight(.black)
                    .padding(8)
                    .foregroundColor(.white)
                    .background(.black.opacity(0.75))
                    .clipShape(Capsule())
                    .offset(x: -5, y: -5)
            }
            
            Text(book.author ?? "Unknown Author")
                .font(.title)
                .foregroundColor(.secondary)
            
            RatingView(rating: .constant(Int(book.rating)))
                .font(.largeTitle)
            
            Text(book.date?.formatted(date: .abbreviated, time: .shortened) ?? "Unknown date")
            
            Text(book.review ?? "No review")
                .padding()
        }
        .navigationTitle(book.title ?? "Unknown Book")
        .navigationBarTitleDisplayMode(.inline)
        .alert("Delete book?", isPresented: $showingDeleteAlert) {
            Button("Delete", role: .destructive, action: deleteBook)
            Button("Cancel", role: .cancel) {}
        } message: {
            Text("Are you sure?")
        }
        .toolbar {
            Button {
                showingDeleteAlert = true
            } label: {
                Label("Delete this book", systemImage: "trash")
            }
        }
    }
    
    func deleteBook() {
        
        modelContext.delete(book)
        
        try? modelContext.save()
        dismiss()
    }
}
