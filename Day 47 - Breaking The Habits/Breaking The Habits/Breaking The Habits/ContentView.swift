//
//  ContentView.swift
//  Breaking The Habits
//
//  Created by Maxim Datskiy on 6/28/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var habits = Habits()
    
    @State private var showingEditSheet = false
    
    
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(habits.items) { item in
//                    HStack {
//                        Text("will come later")
//                    } label: {
                        VStack {
                            Text(item.name)
//                                .font(.headline)
//                                .multilineTextAlignment(.leading)
                            Text(item.description)
                                .opacity(0.7)
//                                .multilineTextAlignment(.leading)
                        }
                        .swipeActions(edge: .leading) {
                            HStack {
//                                        Button {
//                                            habits.items.remove(atOffsets: )
//                                        } label: {
//                                            Label("Delete", systemImage: "trash")
//                                        }
//                                        .tint(.red)
                                
                                Button {
                                    //wsfda
                                } label: {
                                    Label("Edit", systemImage: "pencil")
                                }
                                .tint(.blue)
                            }
                        }
//                    }

                }
                .onDelete(perform: removeItems)
            }
            .navigationTitle("Habits")
            .toolbar {
                Button {
                    showingEditSheet.toggle()
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $showingEditSheet) {
                AddHabitView(habits: Habits())
                    .presentationDetents([.height(200), .height(200)])
            }
        }
        .padding()
    }
    
    func removeItems(at offsets: IndexSet) {
        habits.items.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
