//
//  ContentView.swift
//  LayoutAndGeometry
//
//  Created by Maxim Datskiy on 3/6/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
//        DAY 1
        
//        PART 3 - Alignment and alignment guides

        VStack(alignment: .leading) {
            ForEach(1..<10) { position in
                Text("Number \(position)")
                    .alignmentGuide(.leading, computeValue: { _ in
                        Double(position) * -10
                    })
            }
        }
        .background(.red)
        .frame(width: 400, height: 400)
        .background(.cyan)
        
//        VStack(alignment: .leading) {
//            Text("Hello World")
//                .alignmentGuide(.leading, computeValue: { d in
//                    d[.trailing]
//                })
//
//            Text("Placeholder with a longer text line")
//        }
//        .background(.red)
//        .frame(width: 400, height: 400)
//        .background(.cyan)
        
//        HStack(alignment: .lastTextBaseline) {
//            Text("Live")
//                .font(.caption)
//            
//            Text("long")
//            
//            Text("and")
//                .font(.title)
//            
//            Text("prosper")
//                .font(.largeTitle)
//        }
        
//        Text("Live long and prosper")
//            .foregroundStyle(.white)
//            .frame(width: 300, height: 300, alignment: .leading)
//            .background(.cyan)
        
//        PART 2 - How layout works in SwiftUI
        
//        Color.cyan
        
//        Text("Hello, world!")
//            .padding()
//            .background(.mint)
//            .clipShape(.capsule)
//            .padding()
//            .background(.red)
//            .clipShape(.capsule)
        
//        PART 1 - Create the Project
    }
}

#Preview {
    ContentView()
}
