//
//  AstronautView.swift
//  Moonshot
//
//  Created by Maxim Datskiy on 6/17/23.
//

import SwiftUI

struct AstronautView: View {
    
    let astronaut: Astronaut
    
    var body: some View {
        ScrollView {
            VStack {
                Image(decorative: astronaut.id)
                    .resizable()
                    .scaledToFit()
                
                Text(astronaut.description)
                    .padding()
                    .foregroundColor(.white)
            }
        }
        .background(.darkBackground)
        .navigationTitle(astronaut.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    let astronauts: [String: Astronaut] = FileManager.default.decode("astronauts.json")
    
    AstronautView(astronaut: astronauts["armstrong"]!)
}
