//
//  ListLayout.swift
//  Moonshot
//
//  Created by Maxim Datskiy on 6/19/23.
//

import SwiftUI

struct ListLayout: View {
    let missions: [Mission]
    let astronauts: [String: Astronaut]
    
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(missions) { mission in
                    NavigationLink(value: mission) {
                        HStack {
                            Image(decorative: mission.image)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 50, height: 50)
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
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .background(.lightBackground)
                            .accessibilityElement()
                            .accessibilityLabel("Mission: \(mission.displayName)")
                            .accessibilityHint("Launch Date: \(mission.formattedLaunchDate)")
                        }
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.lightBackground))
                    }
                }
            }
            .padding([.horizontal, .bottom])
            .listStyle(.plain)
            .listRowBackground(Color.darkBackground)
            .navigationDestination(for: Mission.self) { mission in
                MissionView(mission: mission)
            }
        }
        .background(.darkBackground)
    }
}

#Preview {
    let missions: [Mission] = FileManager.default.decode("missions.json")
    let astronauts: [String: Astronaut] = FileManager.default.decode("astronauts.json")
    
    ListLayout(missions: missions, astronauts: astronauts)
}

