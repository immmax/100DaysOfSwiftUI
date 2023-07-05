//
//  AddActivityView.swift
//  Breaking The Habits
//
//  Created by Maxim Datskiy on 7/4/23.
//

import SwiftUI

struct AddActivityView: View {
    @StateObject var activities = Activities()
    @Environment(\.dismiss) var dismiss
    @State private var comment = ""
    @FocusState private var commentFocused
    var habitID: UUID
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Comment", text: $comment)
                    .focused($commentFocused)
                    .submitLabel(.done)
            }
            .navigationTitle("Add New Activity")
            .onSubmit {
                guard comment.isEmpty == false else {
                    print("Empty field")
                    return
                }
                let item = ActivityItem(habitID: habitID, date: Date.now, comment: comment)
                activities.items.append(item)
                dismiss()
            }
        }
    }
    
    init(habitID: UUID) {
        self.habitID = habitID
    }
}

struct AddActivityView_Previews: PreviewProvider {
    static var habitID = UUID()
    
    static var previews: some View {
        AddActivityView(habitID: habitID)
    }
}
