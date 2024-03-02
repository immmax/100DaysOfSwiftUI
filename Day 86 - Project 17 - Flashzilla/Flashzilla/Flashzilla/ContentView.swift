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
    
    @State private var currentAmount = Angle.zero
    @State private var finalAmount = Angle.zero
    
    @State private var offset = CGSize.zero
    @State private var isDragging = false
    
    var body: some View {
        let dragGesture = DragGesture()
            .onChanged { value in
                offset = value.translation
            }
            .onEnded { _ in
                withAnimation {
                    offset = .zero
                    isDragging = false
                }
            }
        
        let pressGesture = LongPressGesture()
            .onEnded { value in
                withAnimation {
                    isDragging = true
                }
            }
        
        let combined = pressGesture.sequenced(before: dragGesture)
        
        Circle()
            .fill(.red)
            .frame(width: 64, height: 64)
            .scaleEffect(isDragging ? 1.5 : 1)
            .offset(offset)
            .gesture(combined)
        
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
            
    }
}

#Preview {
    ContentView()
}
