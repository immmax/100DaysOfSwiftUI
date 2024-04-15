//
//  FlagImage.swift
//  GuessTheFlag
//
//  Created by Maxim Datskiy on 4/14/24.
//

import SwiftUI

struct FlagImageView: View {
    
    @State private var viewModel = FlagImageViewModel()
    var text: String
    
    var body: some View {
        Image(text)
            .renderingMode(.original)
            .clipShape(Capsule())
            .shadow(radius: 5)
            .accessibilityLabel(viewModel.labels[text, default: "Unknown flag"])
    }
}

#Preview {
    FlagImageView(text: "")
}
