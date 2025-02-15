//
//  AddBookView .swift
//  Bookworm
//
//  Created by Maxim Datskiy on 7/26/23.
//

import SwiftUI

struct AddBookView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    
    @State private var title = ""
    @State private var author = ""
    @State private var rating = 3
    @State private var genre = "General"
    @State private var review = ""
    @State private var date = Date.now
    
    let genres = ["General", "Fantasy", "Horror", "Kids", "Mystery", "Poetry", "Romance", "Thriller"]
    
    var isBookInvalid: Bool {
        return (title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty) ||
               (author.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Name of book", text: $title)
                    TextField("Author's name", text: $author)
                    
                    Picker("Genre", selection: $genre) {
                        ForEach(genres, id: \.self) {
                            Text($0)
                        }
                    }
                }
                
                Section {
                    RatingView(rating: $rating)
                    TextEditor(text: $review)
                } header: {
                    Text("Write a review")
                }
                
                Section {
                    Button("Save") {
                        let newBook = Book(
                            title: title,
                            author: author,
                            rating: Int16(rating),
                            genre: genre,
                            review: review,
                            date: date
                        )
                        
                        modelContext.insert(newBook)
                        
                        dismiss()
                    }
                    .disabled(isBookInvalid)
                }
            }
            .navigationTitle("Add Book")
        }
    }
}

#Preview {
    AddBookView()
}
