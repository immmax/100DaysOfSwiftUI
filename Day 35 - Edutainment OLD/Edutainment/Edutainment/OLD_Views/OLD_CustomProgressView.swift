//
//  CustomProgressView.swift
//  Edutainment
//
//  Created by Maxim Datskiy on 4/18/24.
//

import SwiftUI

struct CustomProgressView: View {
    
    let progress: CGFloat
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle()
                    .frame(width: geometry.size.width, height: 10)
                    .foregroundStyle(.gray.opacity(0.3))
                
                Rectangle()
                    .frame(
                        width: min(progress * geometry.size.width,
                                   geometry.size.width),
                        height: 10)
                    .foregroundStyle(.green)
            }
        }
    }
}
