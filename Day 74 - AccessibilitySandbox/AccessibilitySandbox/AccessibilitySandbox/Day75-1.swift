//
//  Day75-1.swift
//  AccessibilitySandbox
//
//  Created by Maxim Datskiy on 2/21/25.
//

import SwiftUI

struct Day75_1: View {
    var body: some View {
        Button("John Fitzgerald Kennedy") {
            print("Button Tapped")
        }
        .accessibilityInputLabels(["John Fitzgerald Kennedy", "Kennedy", "JFK"])
    }
}

#Preview {
    Day75_1()
}
