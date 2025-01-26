//
//  CrewView.swift
//  Moonshot
//
//  Created by Maxim Datskiy on 6/19/23.
//

import SwiftUI

struct CrewView: View {
    struct CrewMember: Hashable {
        let role: String
        let astronaut: Astronaut
    }
    
    let mission: Mission
    let crew: [CrewMember]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(crew, id: \.role) { crewMember in
                    NavigationLink(value: crewMember) {
                        VStack {
                            Image(decorative: crewMember.astronaut.id)
                                .resizable()
                                // .scaledToFit()
                                .frame(width: 104, height: 72)
                                .clipShape(RoundedRectangle(cornerRadius: 25))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 25)
                                        .strokeBorder(.white, lineWidth: 1)
                                )
                                
                            Text(crewMember.astronaut.name)
                                .foregroundColor(.white)
                                .font(.headline)
                            Text(crewMember.role)
                                .foregroundColor(.secondary)
                        }
                        .padding(.horizontal)
                        .accessibilityElement()
                        .accessibilityLabel(
                            """
                            \(crewMember.astronaut.name),
                            \(crewMember.role)
                            """
                        )
                    }
                    .navigationDestination(for: CrewMember.self) { crewMember in
                        AstronautView(astronaut: crewMember.astronaut)
                    }
                }
            }
        }
    }
    
    init(mission: Mission, astronauts: [String: Astronaut]) {
        self.mission = mission
        self.crew = mission.crew.map { member in
            if let astronaut = astronauts[member.name] {
                return CrewMember(role: member.role, astronaut: astronaut)
            } else {
                fatalError("Missing \(member.name)")
            }
        }
    }
    
}

#Preview {
    let missions: [Mission] = FileManager.default.decode("missions.json")
    let astronauts: [String: Astronaut] = FileManager.default.decode("astronauts.json")
    
    CrewView(mission: missions[5], astronauts: astronauts)
        .preferredColorScheme(.dark)
}

