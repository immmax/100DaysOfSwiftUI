//
//  ContentView.swift
//  SnowSeeker
//
//  Created by Maxim Datskiy on 3/1/25.
//

import SwiftUI

struct UserView: View {
    var body: some View {
        Group {
            Text("Name: Max")
            Text("Country: USA")
            Text("Cars: 2022 Toyota Highlander and 2005 Honda Accord")
        }
        .font(.title)
    }
}

struct ContentView: View {
//    @State private var layoutVertically = false
//    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    
    var body: some View {
//        Button {
//            layoutVertically.toggle()
//        } label: {
//        if horizontalSizeClass == .compact {
//            VStack(content: UserView.init)
//        } else {
//            HStack(content: UserView.init)
//        }
//        }
        
        ViewThatFits {
            Rectangle()
                .frame(width: 500, height: 200)
            
            Circle()
                .frame(width: 200, height: 200)
        }
    }
}

#Preview {
    ContentView()
}
