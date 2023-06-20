//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Maxim Datskiy on 4/27/23.
//

import SwiftUI

struct ContentView: View {
    @State private var showingAlert = false
    
    var body: some View {
        
//        VStack(spacing: 25) {
//            HStack {
//                Text("1")
//                Text("2")
//                Text("3")
//            }
//            HStack {
//                Text("4")
//                Text("5")
//                Text("6")
//            }
//            HStack {
//                Text("7")
//                Text("8")
//                Text("9")
//            }
//
//            Image(systemName: "globe")
//                .imageScale(.large)
//                .foregroundColor(.accentColor)
//
//        }
        
//        ZStack {
//            VStack(spacing: 0) {
//                Color.red
//                Color.blue
//                    //.frame(minWidth: 250, maxWidth: .infinity, maxHeight: 250)
//            }
//            Text("Your content")
//                .foregroundStyle(.secondary)
//                .padding(1200)
//                .background(.ultraThinMaterial)
//        }
//        .ignoresSafeArea()
        
        //LinearGradient(gradient: Gradient(colors: [.blue, .yellow]), startPoint: .top, endPoint: .bottom)
//        LinearGradient(gradient: Gradient(stops: [
//            //Gradient.Stop(color: .blue, location: 0.45),
//            //Gradient.Stop(color: .yellow, location: 0.55)
//            .init(color: .blue, location: 0.45),
//            .init (color: .yellow, location: 0.55)
//        ]), startPoint: .top, endPoint: .bottom)
    
        //RadialGradient(gradient: Gradient(colors: [.white, .red, .blue]), center: .center, startRadius: 20, endRadius: 150 )
        //ZStack() {
            //AngularGradient(gradient: Gradient(colors: [.red, .yellow, .green, .blue, .purple, .red]), center: .center)
            
         //   Button("Delete selection", role: .destructive, action: executeDelete)
//                .padding(15)
//                .foregroundColor(.white)
//                .background(.ultraThinMaterial)
        //}
//        VStack {
//            Button("Button 1") { }
//                .buttonStyle(.bordered)
//            Button("Button 2", role: .destructive) { }
//                .buttonStyle(.bordered)
//            Button("Button 3") { }
//                .buttonStyle(.borderedProminent)
//                .tint(.mint)
//            Button("Button 4", role: .destructive) { }
//                .buttonStyle(.borderedProminent)

//            Button {
//                print("Edit button was tapped")
//            } label: {
////                Text("Tap me!")
////                    .padding()
////                    .background(.red)
////                    .foregroundColor(.white)
////                or
////                Image(systemName: "pencil")
////                or
//                Label("Edit", systemImage: "pencil")
//            }
//            Spacer()
//        }
        
//        Image(systemName: "pencil")
//            .renderingMode(.original)
        var count = 0
        Button ("Show Alert") {
            count += 1
            if count == 5 {
                showingAlert = true
            }
        }
        .alert("Congratulations!", isPresented: $showingAlert) {
            Button("Delete", role: .destructive) { }
            Button("Cancel", role: .cancel) { }
        } message: {
            Text("You counted to 5!")
        }
    }
    
//    func executeDelete() {
//        print("Now deleting...")
//    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
