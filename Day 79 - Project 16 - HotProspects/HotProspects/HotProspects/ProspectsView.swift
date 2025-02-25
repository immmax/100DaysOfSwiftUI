//
//  ProspectsView.swift
//  HotProspects
//
//  Created by Maxim Datskiy on 11/20/23.
//

import CodeScanner
import SwiftData
import SwiftUI
import UserNotifications

enum SortOption: String, CaseIterable {
    case byName, mostRecent
}

extension SortOption {
    var systemImage: String {
        switch self {
        case .byName:
            "textformat.size.larger"
        case .mostRecent:
            "calendar"
        }
    }
    
    var description: String {
        switch self {
        case .byName:
            return "By Name"
        case .mostRecent:
            return "Most Recent"
        }
    }
}

struct ProspectsView: View {
    @State private var number = 0
    
    enum FilterType {
        case none, contacted, uncontacted
    }
    
    @Environment(\.modelContext) var modelContext
    @Query var prospects: [Prospect]
    
    @State private var isShowingScanner = false
    @State private var isShowingEditor = false
    @State private var selectedProspects = Set<Prospect>() // for multiple selection to remove
    
    let filter: FilterType
    @State private var selectedSortOption = SortOption.allCases.first!
    
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
    
    var body: some View {
        NavigationStack {
            List(prospects.sort(on: selectedSortOption), selection: $selectedProspects) { prospect in
                NavigationLink {
                    EditProspectView(prospect: prospect)
                } label: {
                    HStack {
                        if filter == .none {
                            Image(systemName: prospect.isContacted ? "person.crop.circle.badge.plus" : "person.crop.circle.badge.xmark")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 40, height: 40)
                                .foregroundStyle(prospect.isContacted ? .green : .red)
                        }
                        
                        VStack(alignment: .leading) {
                            Text(prospect.name)
                                .font(.headline)
                            Text(prospect.email)
                                .foregroundColor(.secondary)
                        }
                    }
                }
                .swipeActions {
                    Button("Delete", systemImage: "trash", role: .destructive) {
                        modelContext.delete(prospect)
                    }
                    
                    if prospect.isContacted {
                        Button("Mark Uncontacted", systemImage: "person.crop.circle.badge.xmark") {
                            prospect.isContacted.toggle()
                        }
                        .tint(.blue)
                    } else {
                        Button("Mark Contacted", systemImage:"person.crop.circle.fill.badge.checkmark") {
                            prospect.isContacted.toggle()
                        }
                        .tint(.green)
                        
                        Button("Remind me", systemImage: "bell") {
                            addNotification(for: prospect)
                        }
                        .tint(.orange)
                    }
                }
                .tag(prospect) // this is required for multiple selection
            }
            .navigationTitle(title)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Scan", systemImage: "qrcode.viewfinder") {
                        isShowingScanner = true
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    // temp button for tests
                    Button("Add") {
                        let prospect = Prospect(name: "Max \(number)", email: "max@gmail.com", dateAdded: .now, isContacted: false)
                        modelContext.insert(prospect)
                        number += 1
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Menu("Sort Prospects", systemImage: "arrow.up.arrow.down") {
                        Picker("Sort", selection: $selectedSortOption) {
                            ForEach(SortOption.allCases, id: \.rawValue) {option in
                                Label(option.description,
                                      systemImage: option.systemImage)
                                    .tag(option)
                            }
                        }
                    }
                }
                
                ToolbarItem(placement: .topBarLeading) {
                    EditButton()
                }
                
                if selectedProspects.isEmpty == false {
                    ToolbarItem(placement: .bottomBar) {
                        Button("Delete Selected", role: .destructive, action: delete)
                    }
                }
            }
            .sheet(isPresented: $isShowingScanner) {
                CodeScannerView(codeTypes: [.qr],
                                simulatedData: "Max Datskiy\nmax@email.com",
                                completion: handleScan)
            }
            .onAppear {
                selectedProspects = []
            }
        }
    }
    
    init(filter: FilterType) {
        self.filter = filter
        
        if filter != .none {
            
            let showContactedOnly = filter == .contacted
            
            _prospects = Query(filter: #Predicate {
                $0.isContacted == showContactedOnly
            }, sort: [SortDescriptor(\Prospect.name)])
        }
    }
    
    func handleScan(result: Result<ScanResult, ScanError>) {
        isShowingScanner = false
        
        switch result {
        case .success(let result):
            let details = result.string.components(separatedBy: "\n")
            guard details.count == 2 else { return }
            
            let person = Prospect(name: details[0], email: details[1], dateAdded: Date.now, isContacted: false)
            modelContext.insert(person)
             
        case .failure(let error):
            print("Scanning failed: \(error.localizedDescription)")
            
        }
    }
    
    func delete() {
        for prospect in selectedProspects {
            modelContext.delete(prospect)
        }
    }
    
    func addNotification(for prospect: Prospect) {
        let center = UNUserNotificationCenter.current()
        
        let addRequest = {
            let content = UNMutableNotificationContent()
            content.title = "Contact \(prospect.name)"
            content.subtitle = prospect.email
            content.sound = UNNotificationSound.default
            
//            var dateComponents = DateComponents()
//            dateComponents.hour = 9
//            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
            
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false) //test
            
            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
            center.add(request)
        }
        
        center.getNotificationSettings { settings in
            if settings.authorizationStatus == .authorized {
                addRequest()
            } else {
                center.requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                    if success {
                        addRequest()
                    } else if let error {
                        print("D'oh!")
                        print(error.localizedDescription)
                    }
                }
            }
        }
    }
}

private extension [Prospect] {
    func sort(on option: SortOption) -> [Prospect] {
        switch option {
        case .byName:
            self.sorted(by: {$0.name < $1.name})
        case .mostRecent:
            self.sorted(by: {$0.dateAdded < $1.dateAdded})
        }
    }
}

#Preview {
    ProspectsView(filter: .none)
        .modelContainer(for: Prospect.self)
}
