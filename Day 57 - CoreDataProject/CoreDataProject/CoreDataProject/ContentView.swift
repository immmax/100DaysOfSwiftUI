//
//  ContentView.swift
//  CoreDataProject
//
//  Created by Maxim Datskiy on 7/29/23.
//

import SwiftUI

struct Student: Hashable {
    let name: String
}

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    
    @FetchRequest(sortDescriptors: []) var wizards: FetchedResults<Wizard>
    
    @State private var wizardName = ""
    
    let students = [Student(name: "Michael Scott"), Student(name: "Jim Halpert")]
    
    var body: some View {
        VStack {
            Section("Enter wizard's name") {
                TextField("Wizard's Name", text: $wizardName)
            }
            
            Section {
                List(wizards, id: \.self) { wizard in
                    Text(wizard.name ?? "Unknown")
                }
            }
            
            
            Section {
                HStack {
                    Button("Add") {
                        let wizard = Wizard(context: moc)
                        wizard.name = wizardName
                        
                        wizardName = ""
                    }
                    .buttonStyle(.bordered)
                    .padding(.horizontal)
                    
                    Button("Save") {
                        do {
                            if moc.hasChanges {
                                try moc.save()
                            }
                            wizardName = ""
                        } catch {
                            print(error.localizedDescription)
                        }
                    }
                    .buttonStyle(.borderedProminent)
                    .padding(.horizontal)
                }
            }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
