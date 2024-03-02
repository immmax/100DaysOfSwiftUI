//
//  ContentView.swift
//  Flashzilla
//
//  Created by Maxim Datskiy on 3/1/24.
//

import SwiftUI

struct ContentView: View {
//    @State private var currentAmount = 0.0
//    @State private var finalAmount = 1.0
    
//    @State private var currentAmount = Angle.zero
//    @State private var finalAmount = Angle.zero
//    
//    @State private var offset = CGSize.zero
//    @State private var isDragging = false
    
    let timer = Timer.publish(every: 1, tolerance: 0.5, on: .main, in: .common).autoconnect()
    @State private var counter = 0
    var body: some View {
        // DAY 97 BELOW
        // Part 1
        Text("Hello, world!")
            .onReceive(timer) { time in
                if counter == 5 {
                    timer.upstream.connect().cancel()
                } else {
                    print("The time is now \(time)")
                }
                counter += 1
            }
    }

        // DAY 86 BELOW
        // part 3 below
//        VStack {
//            Text("Hello")
//            
//            Spacer()
//                .frame(height: 100)
//            
//            Text("World")
//        }
//        .contentShape(.rect)
//        .onTapGesture {
//            print("VStack tapped!")
//        }
        
//        ZStack {
//            Rectangle()
//                .fill(.blue)
//                .frame(width: 300, height: 300)
//                .onTapGesture {
//                    print("Rectangle tapped!")
//                }
//            
//            Circle()
//                .fill(.red)
//                .frame(width: 300, height: 300)
//                .contentShape(.rect)
//                .onTapGesture {
//                    print("Circle tapped!")
//                }
//                .allowsHitTesting(false)
//        }
        
        // part 2 below
//        let dragGesture = DragGesture()
//            .onChanged { value in
//                offset = value.translation
//            }
//            .onEnded { _ in
//                withAnimation {
//                    offset = .zero
//                    isDragging = false
//                }
//            }
//        
//        let pressGesture = LongPressGesture()
//            .onEnded { value in
//                withAnimation {
//                    isDragging = true
//                }
//            }
//        
//        let combined = pressGesture.sequenced(before: dragGesture)
//        
//        Circle()
//            .fill(.red)
//            .frame(width: 64, height: 64)
//            .scaleEffect(isDragging ? 1.5 : 1)
//            .offset(offset)
//            .gesture(combined)
        
        // part 1 below
//        VStack {
//            Text("Hello, world!")
//                .onTapGesture {
//                    print("Text has been tapped")
//                }
//        }
//        .simultaneousGesture (
//            TapGesture()
//                .onEnded {
//                    print("VStack has been tapped")
//                }
//        )
//        .highPriorityGesture (
//            TapGesture()
//                .onEnded {
//                    print("VStack has been tapped")
//                }
//        )
        
//        Text("Hello, world!")
//            .onTapGesture(count: 2) {
//                print("Double Tapped")
//            }
//            .onLongPressGesture(minimumDuration: 2) {
//                print("Long pressed!")
//            } onPressingChanged: { inProgress in
//                print("In progress: \(inProgress)")
//            }
////            .scaleEffect(finalAmount + currentAmount)
//            .rotationEffect(finalAmount + currentAmount)
//            .gesture(
////                MagnifyGesture()
////                    .onChanged { value in
////                        currentAmount = value.magnification - 1
////                    }
////                    .onEnded { value in
////                        finalAmount += currentAmount
////                        currentAmount = 0
////                    }
//                RotateGesture()
//                    .onChanged { value in
//                        currentAmount = value.rotation
//                    }
//                    .onEnded { value in
//                        finalAmount += currentAmount
//                        currentAmount = .zero
//                    }
//            )
            
//    }
}

#Preview {
    ContentView()
}
