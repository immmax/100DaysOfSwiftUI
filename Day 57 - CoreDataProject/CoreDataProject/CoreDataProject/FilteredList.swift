//
//  FilteredList.swift
//  CoreDataProject
//
//  Created by Maxim Datskiy on 8/1/23.
//

import CoreData
import SwiftUI

enum PredicateType {
    case beginsWith, endsWith, contains
}


struct FilteredList<T: NSManagedObject, Content: View>: View {
    @FetchRequest var fetchRequest: FetchedResults<T>
    let content: (T)  -> Content
    var predicateType: String

    var body: some View {
        List(fetchRequest, id: \.self) { item in
            self.content(item)
        }
    }

    init(filterKey: String, filterValue: String, predicateType: String, @ViewBuilder content: @escaping (T) -> Content) {
        self.predicateType = predicateType
        _fetchRequest = FetchRequest<T>(sortDescriptors: [], predicate: NSPredicate(format: "%K \(predicateType) %@", filterKey, filterValue))

    init(filterKey: String, filterValue: String, predicateType: PredicateType, @ViewBuilder content: @escaping (T) -> Content) {
        switch predicateType {
        case .beginsWith:
            self.predicateType = "BEGINSWITH"
        case .endsWith:
            self.predicateType = "ENDSWITH"
        case .contains:
            self.predicateType = "CONTAINS"
        }
        _fetchRequest = FetchRequest<T>(sortDescriptors: [], predicate: NSPredicate(format: "%K \(self.predicateType) %@", filterKey, filterValue))
        self.content = content
    }
}
