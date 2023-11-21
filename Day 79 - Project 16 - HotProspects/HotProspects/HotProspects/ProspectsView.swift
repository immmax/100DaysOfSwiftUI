//
//  ProspectsView.swift
//  HotProspects
//
//  Created by Maxim Datskiy on 11/20/23.
//

import SwiftUI

struct ProspectsView: View {
    enum FilterType {
        case none, contacted, uncontacted
    }
    
    let filter: FilterType
    
    @EnvironmentObject var prospects: Prospects
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(filteredProspects) { prospect in
                    VStack(alignment: .leading) {
                        Text(prospect.name)
                            .font(.headline)
                        Text(prospect.email)
                            .foregroundColor(.secondary)
                    }
                }
            }
            .navigationTitle(title)
            .toolbar {
                Button {
                    let prospect = Prospect()
                    prospect.name = "Max Datskiy"
                    prospect.email = "datskiumax@gmail.com"
                    prospects.people.append(prospect)
                } label: {
                    Label("Scan", systemImage: "qrcode.viewfinder")
                }
            }
        }
    }
    
    var title: String {
        switch filter {
        case .none:
            return "Everyone"
        case .contacted:
            return "Contacted People"
        case .uncontacted:
            return "Uncontacted People"
        }
    }
    
    var filteredProspects: [Prospect] {
        switch filter {
        case .none:
            return prospects.people
        case .contacted:
            return prospects.people.filter { $0.isContacted }
        case .uncontacted:
            return prospects.people.filter { !$0.isContacted }
        }
    }
}

#Preview {
    ProspectsView(filter: .none)
        .environmentObject(Prospects())
}
