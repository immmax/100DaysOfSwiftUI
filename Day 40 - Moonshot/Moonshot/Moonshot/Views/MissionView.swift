//
//  MissionView.swift
//  Moonshot
//
//  Created by Maxim Datskiy on 6/16/23.
//

import SwiftUI

struct MissionView: View {
    let mission: Mission
    let astronauts: [String: Astronaut] = FileManager.default.decode("astronauts.json")
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack {
                    Image(mission.image)
                        .resizable()
                        .scaledToFit() 
                        .frame(maxWidth: geometry.size.width * 0.6)
                        .padding()
                    
                    Text(mission.formattedLaunchDate)
                        .font(.headline.bold())
                        .foregroundColor(.white.opacity(0.5))
                    
                    VStack(alignment: .leading) {
                        Rectangle()
                            .divider()
                        
                        Text("Mission Highlights")
                            .font(.title.bold())
                            .padding(.bottom, 5)
                        
                        Text(mission.description)

                        Rectangle()
                            .divider()
                        
                        Text("Crew")
                            .font(.title.bold())
                            .padding(.bottom, 5)
                    }
                    .padding(.horizontal)
                    
                    CrewView(mission: mission, astronauts: astronauts)
                }
                .padding(.bottom)
            }
            .navigationTitle(mission.displayName)
            .navigationBarTitleDisplayMode(.inline)
            .background(.darkBackground)
        }
    }
}

struct MissionView_Previews: PreviewProvider {
    static let missions: [Mission] = FileManager.default.decode("missions.json")
    
    static var previews: some View {
        MissionView(mission: missions[0])
            .preferredColorScheme(.dark)
    }
}
