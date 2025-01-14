//
//  CustomGridView.swift
//  Edutainment
//
//  Created by Maxim Datskiy on 4/21/24.
//

import SwiftUI

protocol CustomGridViewDelegate {
    func answerTapped(_ value: Int)
}

struct CustomGridView: View {
    
    let numbers: [Int]
//    var delegate: CustomGridViewDelegate
    let columns = Array(repeating: GridItem(.fixed(150), spacing: 30), count: 2)
    
    var body: some View {
        LazyVGrid(columns: columns, spacing: 30) {
            ForEach(numbers, id: \.self) { number in
                Button { print(number) } label: {
                    Text("\(number)")
                        .frame(width: 150, height: 100)
                        .font(.largeTitle.bold())
                        .background(.blue.opacity(0.9))
                        .foregroundStyle(.white)
                        .clipShape(.rect(cornerRadius: 20))
                }
            }
        }
    }
}

#Preview {
    CustomGridView(numbers: [1, 2, 3, 4])
}
