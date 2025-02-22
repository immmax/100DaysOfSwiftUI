//
//  Day74-2.swift
//  AccessibilitySandbox
//
//  Created by Maxim Datskiy on 2/21/25.
//

import SwiftUI

struct Day74_2: View {
    var body: some View {
//        Image(decorative: "galina-n-189483")
        
//        Image("galina-n-189483")
//            .accessibilityHidden(true)
        
        VStack {
            Text("Your score is")
            
            Text("1000")
                .font(.title)
        }
//        .accessibilityElement(children: .combine)
//        .accessibilityElement(children: .ignore) // ignore - default value
        .accessibilityElement()
        .accessibilityLabel("Your score is 1000")
    }
}

#Preview {
    Day74_2()
}
