//
//  GridLayout.swift
//  Moonshot
//
//  Created by Maxim Datskiy on 6/19/23.
//

import SwiftUI

struct GridLayout: View {
    let missions: [Mission]
    let astronauts: [String: Astronaut]
    
    let columns = [
        GridItem(.adaptive(minimum: 150))
    ]

    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns) {
                ForEach(missions) { mission in
                    NavigationLink {
                        VStack {
                            MissionView(mission: mission)
                        }
                        .padding()
                        
                    } label: {
                        VStack {
                            Image(decorative: mission.image)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                                .padding()

                            VStack {
                                Text(mission.displayName)
                                    .font(.headline)
                                    .foregroundColor(.white)

                                Text(mission.formattedLaunchDate)
                                    .font(.caption)
                                    .foregroundColor(.white.opacity(0.5))
                            }
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(.lightBackground)
                        }
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.lightBackground))
                    }
                }
            }
            .padding([.horizontal, .bottom])
        }
        .background(.darkBackground)
    }
    
    
    init(missions: [Mission], astronauts: [String: Astronaut]) {
        self.missions = missions
        self.astronauts = astronauts
    }
}

struct GridLayout_Previews: PreviewProvider {
    static let missions: [Mission] = FileManager.default.decode("missions.json")
    static let astronauts: [String: Astronaut] = FileManager.default.decode("astronauts.json")
    
    
    static var previews: some View {
        GridLayout(missions: missions, astronauts: astronauts)
    }
}
