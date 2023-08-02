//
//  FilteredList.swift
//  CoreDataProject
//
//  Created by Maxim Datskiy on 8/1/23.
//

import CoreData
import SwiftUI

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
        self.content = content
    }
}
