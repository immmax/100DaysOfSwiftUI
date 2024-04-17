//
//  MoveImageView.swift
//  RockPaperScissors
//
//  Created by Maxim Datskiy on 4/17/24.
//

import SwiftUI

struct MoveImageView: View {
    var text: String
    
    var body: some View {
        Text(text)
            .font(.system(size: 50))
    }
    init(_ text: String) {
        self.text = text
    }
}

#Preview {
    MoveImageView("hi")
}
