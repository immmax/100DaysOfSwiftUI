//
//  DayVies.swift
//  Drawing
//
//  Created by Maxim Datskiy on 6/26/23.
//

import SwiftUI

struct DayView: View {
    @State private var number: Int
    
    var body: some View {
        if number == 1 { Day_43_View()}
        else if number == 2 { Day_44_View() }
        else if number == 3 { Day_45_View() }
        else {Day_46_View()}
            
    }
    
    init(_ number: Int) {
        self.number = number
    }
}

struct DayView_Previews: PreviewProvider {
    static var number: Int = 1
    
    static var previews: some View {
        DayView(1)
    }
}
