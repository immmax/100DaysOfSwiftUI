//
//  ContentView.swift
//  CoreDataProject
//
//  Created by Maxim Datskiy on 7/29/23.
//

import CoreData
import SwiftUI

struct Student: Hashable {
    let name: String
}

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    
    @FetchRequest(sortDescriptors: []) var wizards: FetchedResults<Wizard>
    
    @FetchRequest(sortDescriptors: [], predicate: NSPredicate(format: "NOT name BEGINSWITH[c] %@", "e")) var ships: FetchedResults<Ship>
    
    @State private var wizardName = ""
    
    let students = [Student(name: "Michael Scott"), Student(name: "Jim Halpert")]
    
    var body: some View {
        VStack {
            Section("WIZARDS") {
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
                        Button("Add Wizard") {
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
            Section("SHIPS") {
                Section("Ships list") {
                    List {
                        ForEach(ships, id: \.self) { ship in
                            Text(ship.name ?? "Unknown name")
                        }
                    }
                }
                
                Section("Ship's control") {
                    Button("Add examples") {
                        let ship1 = Ship(context: moc)
                        ship1.name = "Enterprise"
                        ship1.universe = "Star Trek"
                        
                        let ship2 = Ship(context: moc)
                        ship2.name = "Defiant"
                        ship2.universe = "Star Trek"
                        
                        let ship3 = Ship(context: moc)
                        ship3.name = "Millenium Falcon"
                        ship3.universe = "Star Wars"
                        
                        let ship4 = Ship(context: moc)
                        ship4.name = "Executor"
                        ship4.universe = "Star Wars"
                        
                        try? moc.save()
                    }
                    .buttonStyle(.borderedProminent)
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
