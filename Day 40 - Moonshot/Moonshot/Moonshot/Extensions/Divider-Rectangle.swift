//
//  Divider-Rectangle.swift
//  Moonshot
//
//  Created by Maxim Datskiy on 6/17/23.
//

import Foundation
import SwiftUI

extension Rectangle {
    func divider(_ height: CGFloat? = 2) -> some View{
        self
            .frame(height: height)
            .foregroundColor(.lightBackground)
            .padding(.vertical)
    }
}
    
