//
//  ContentView.swift
//  Animations
//
//  Created by Maxim Datskiy on 5/16/23.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        TabView {
            OneView()
                .tabItem { Image(systemName: "1.circle") }
            
            TwoView()
                .tabItem { Image(systemName: "2.circle") }
            
            ThreeView()
                .tabItem { Image(systemName: "3.circle") }
            
            FourView()
                .tabItem { Image(systemName: "4.circle") }
            
            FiveView()
                .tabItem { Image(systemName: "5.circle") }
            
            SixView()
                .tabItem { Image(systemName: "6.circle") }
            
            SevenView()
                .tabItem { Image(systemName: "7.circle") }
            
            
        }
    }
}

#Preview { ContentView() }
