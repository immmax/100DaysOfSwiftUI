//
//  FourView.swift
//  Animations
//
//  Created by Maxim Datskiy on 4/18/24.
//

import SwiftUI

struct FourView: View {
    
    @State private var enabled = false
    
    var body: some View {
        Button {
            enabled.toggle()
        } label: {
            Text("Tap me")
                .font(.title.bold())
                .frame(width: 200, height: 200)
                .background(enabled ? .blue : .red)
                .foregroundStyle(.white)
                .animation(.easeInOut, value: enabled)
                .clipShape(.rect(cornerRadius: enabled ? 60 : 14))
                .animation(.spring(duration: 1, bounce: 0.7), value: enabled)
        }
    }
}

#Preview {
    FourView()
}
