//
//  DiceView.swift
//  HighRollers
//
//  Created by Maxim Datskiy on 3/11/24.
//

// Сделать кастомную Shape, чтобы в зависимости от числа граней кости изменялся многогранник
// При броске кости сделать градиент, который будет вращаться по этой форме

import SwiftUI

struct DiceView: View {
    
    var number: Int
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .stroke(lineWidth: 2)
                .frame(width: 100, height: 100)
            
            Text("\(number)")
                .font(.largeTitle)
        }
        .padding()
    }
}

#Preview {
    DiceView(number: 25)
}
