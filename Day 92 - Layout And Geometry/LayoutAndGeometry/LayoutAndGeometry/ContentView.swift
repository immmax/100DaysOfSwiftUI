//
//  ContentView.swift
//  LayoutAndGeometry
//
//  Created by Maxim Datskiy on 3/6/24.
//

import SwiftUI

//struct OuterView: View {
//    var body: some View {
//        VStack {
//            Text("Top")
//            
//            InnerView()
//                .background(.green)
//            
//            Text("Bottom")
//        }
//    }
//}
//
//struct InnerView: View {
//    var body: some View {
//        HStack {
//            Text("Left")
//            
//            GeometryReader { proxy in
//                Text("Center")
//                    .background(.cyan)
//                    .onTapGesture {
//                        print("Global center: \(proxy.frame(in: .global).midX) X \(proxy.frame(in: .global).midY)")
//                        print("Custom center: \(proxy.frame(in: .named("Custom")).midX) X \(proxy.frame(in: .named("Custom")).midY)")
//                        print("Local center: \(proxy.frame(in: .local).midX) X \(proxy.frame(in: .local).midY)")
//                    }
//            }
//            .background(.orange)
//            
//            Text("Right")
//        }
//    }
//}

//        Day 1 - PART 4 - How to create a custom alignment guide
//extension VerticalAlignment {
//    enum MidAccountAndName: AlignmentID {
//        static func defaultValue(in context: ViewDimensions) -> CGFloat {
//            context[.top]
//        }
//    }
//    
//    static let midAccountAndName = VerticalAlignment(MidAccountAndName.self)
//}

struct ContentView: View {
//    let colors: [Color] = [.red, .green, .blue, .orange, .pink, .purple, .yellow]
    
    var body: some View {
//        DAY 3/3 - Day 94 - CHALLENGE
        GeometryReader { fullView in
            ScrollView(.vertical) {
                ForEach(0..<50) { index in
                    GeometryReader { proxy in
                        Text("Row #\(index)")
                            .font(.title.bold())
                            .foregroundStyle(.white)
                            .shadow(color: .black, radius: 5)
                            .frame(maxWidth: .infinity)
                            .background(
                                LinearGradient(
                                    gradient: Gradient(colors: [
                                        Color(
                                            hue: Double(index) / Double(49),
                                            saturation: Double(index) / Double(55) + 0.3,
                                            brightness: 1
                                        ),
                                        Color(
                                            hue: Double(index) / Double(49),
                                            saturation: Double(proxy.frame(in: .global).minX) + 0.1,
                                            brightness: 1
                                        )
                                ]),
                                    startPoint: .bottomLeading,
                                    endPoint: .topTrailing
                                )
                            )
                            .opacity(proxy.frame(in: .global).minY / 250.0)
                            .scaleEffect(0.5 + (proxy.frame(in: .global).minY / (proxy.frame(in: .global).minY + fullView.size.height)))
                            .rotation3DEffect(
                                .degrees(proxy.frame(in: .global).minY - fullView.size.height / 2) / 5,
                                axis: (x: 0, y: 1, z: 0)
                            )
                    }
                    .frame(height: 40)
                }
                .scrollTargetLayout()
            }
            .scrollTargetBehavior(.viewAligned)
        }
        
//        DAY 2/3 - Day 93
        
//        PART 4/4 - ScrollView effects using visualEffect() and scrollTargetBehavior()
//        ScrollView(.horizontal, showsIndicators: false) {
//            HStack(spacing: 0) {
//                ForEach(1..<20) {number in
//                    Text("Number \(number)")
//                        .font(.largeTitle)
//                        .padding()
//                        .background(.red)
//                        .frame(width: 200, height: 200)
//                        .visualEffect { content, proxy in
//                            content
//                                .rotation3DEffect(
//                                    .degrees(-proxy.frame(in: .global).minX / 8),
//                                    axis: (x: 0, y: 1, z: 0)
//                                )
//                        }
//                }
//            }
//            .scrollTargetLayout()
//        }
//        .scrollTargetBehavior(.viewAligned)
        
//        PART 3/4 - ScrollView effects using GeometryReader

//        ScrollView(.horizontal, showsIndicators: false) {
//            HStack(spacing: 0) {
//                ForEach(1..<20) {number in
//                    GeometryReader { proxy in
//                        Text("Number \(number)")
//                            .font(.largeTitle)
//                            .padding()
//                            .background(.red)
//                            .rotation3DEffect(
//                                .degrees(-proxy.frame(in: .global).minX / 8),
//                                axis: (x: 0, y: 1, z: 0)
//                            )
//                            .frame(width: 200, height: 200)
//                    }
//                    .frame(width: 200, height: 200)
//                }
//            }
//        }
        
//        GeometryReader {fullView in
//            ScrollView {
//                ForEach(0..<50) {index in
//                    GeometryReader {proxy in
//                        Text("Row #\(index)")
//                            .font(.title)
//                            .frame(maxWidth: .infinity)
//                            .background(colors[index % 7].opacity(0.6))
//                            .rotation3DEffect(
//                                .degrees(proxy.frame(in: .global).minY - fullView.size.height / 2) / 5,
//                                axis: (x: 0, y: 1, z: 0)
//                            )
//                    }
//                    .frame(height: 40)
//                }
//            }
//        }
        
        
//        PART 2/4 - Understanding frames and coordinates inside GeometryReader
        
//        OuterView()
//            .background(.red)
//            .coordinateSpace(name: "Custom")
        
//        VStack {
//            GeometryReader {proxy in
//                Text("Hello, world!")
//                    .frame(width: proxy.size.width * 0.9)
//                    .background(.red)
//            }
//            .background(.green)
//            
//            Text("More text")
//                .background(.blue)
//        }
        
//        PART 1/4 - Resizing images to fit the screen using GeometryReader
//        HStack {
//            Text("IMPORTANT")
//                .frame(width: 200)
//                .background(.cyan)
//            
//            GeometryReader { proxy in
//                Image(.dumb)
//                    .resizable()
//                    .scaledToFit()
//                    .frame(width: proxy.size.width * 0.8)
//                    .frame(width: proxy.size.width, height: proxy.size.height)
////                    .containerRelativeFrame(.horizontal) { size, axis in
////                        size * 0.8
////                    }
//            }
//        }
//        
//        GeometryReader { proxy in
//            Image(.dumb)
//                .resizable()
//                .scaledToFit()
//                .frame(width: proxy.size.width * 0.8)
//        }
        
//        DAY 1/3 - Day 92
        
//        PART 5/5 - Absolute positioning for SwiftUI views
//        Text("Жаксы Рахмет")
////            .position(x:100, y:100)
//            .offset(x:100, y:100)
//            .background(.cyan)
//            .position(x:100, y:100)
////            .offset(x:100, y:100)
        
//        PART 4/5 - How to create a custom alignment guide
        
//        HStack(alignment: .midAccountAndName) {
//            VStack {
//                Text("Twitter")
//                    .font(.largeTitle)
//                Text("@immmax")
//                    .alignmentGuide(.midAccountAndName, computeValue: { d in
//                        d[VerticalAlignment.center]
//                    })
//                
//                Image(.dumb)
//                    .resizable()
//                    .frame(width: 64, height: 64)
//            }
//            
//            VStack {
//                Text("No way")
//                Text("Full name:")
//                
//                Text("JAMES CARRY")
//                    .font(.largeTitle)
//                    .alignmentGuide(.midAccountAndName, computeValue: { d in
//                        d[VerticalAlignment.center]
//                    })
//                Text("Kidding me?")
//            }
//        }
        
//        PART 3/5 - Alignment and alignment guides

//        VStack(alignment: .leading) {
//            ForEach(1..<10) { position in
//                Text("Number \(position)")
//                    .alignmentGuide(.leading, computeValue: { _ in
//                        Double(position) * -10
//                    })
//            }
//        }
//        .background(.red)
//        .frame(width: 400, height: 400)
//        .background(.cyan)
        
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
        
//        PART 2/5 - How layout works in SwiftUI
        
//        Color.cyan
        
//        Text("Hello, world!")
//            .padding()
//            .background(.mint)
//            .clipShape(.capsule)
//            .padding()
//            .background(.red)
//            .clipShape(.capsule)
        
//        PART 1/5 - Create the Project
    }
}

#Preview {
    ContentView()
}
