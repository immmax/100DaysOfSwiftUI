//
//  RollCell.swift
//  HighRollers
//
//  Created by Maxim Datskiy on 4/14/24.
//

import SwiftUI

struct RollCell: View {
    
    let roll: Roll
    
    init(_ roll: Roll) { self.roll = roll }
    
    var body: some View {
        HStack  {
            Text(roll.date.formatted(date: .numeric, time: .shortened))
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Text("\(roll.numbers.reduce(0, +))")
                .frame(maxWidth: .infinity, alignment: .trailing)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal)
        .padding(.vertical, 5)
    }
}

#Preview {
    RollCell(Roll(date: .now, numbers: [14, 11, 25]/*, type: 25*/))
}
