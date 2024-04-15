//
//  CustomModifiers.swift
//  GuessTheFlag
//
//  Created by Maxim Datskiy on 4/14/24.
//

import SwiftUI

struct Title: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .font(.largeTitle.bold())
            .foregroundColor(.white)
    }
}
