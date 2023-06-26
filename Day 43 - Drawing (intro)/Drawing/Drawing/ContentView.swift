//
//  ContentView.swift
//  Drawing
//
//  Created by Maxim Datskiy on 6/23/23.
//

import SwiftUI

struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxY, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
        return path
    }
}

struct Arc: InsettableShape {
    let startAngle: Angle
    let endAngle: Angle
    let clockwise: Bool
    var insetAmount = 0.0
    
    func path(in rect: CGRect) -> Path {
        let rotationAdjustment = Angle.degrees(90)
        let modifiedStart = startAngle - rotationAdjustment
        let modifiedEnd = endAngle - rotationAdjustment
        
        var path = Path()
        path.addArc(center: CGPoint(x: rect.midX, y: rect.midY), radius: rect.width / 2 - insetAmount, startAngle: modifiedStart, endAngle: modifiedEnd, clockwise: !clockwise)
        return path
    }
    
    func inset(by amount: CGFloat) -> some InsettableShape {
        var arc = self
        arc.insetAmount += amount
        return arc
    }
}

struct Flower: Shape {
    var petalOffset = -20.0
    var petalWidth = 100.0
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        for number in stride(from: 0.1, through: Double.pi * 2, by: Double.pi / 8) {
            let rotation = CGAffineTransform(rotationAngle: number)
            let position = rotation.concatenating(CGAffineTransform(translationX: rect.width / 2, y: rect.height / 2))
            
            let originalPetal = Path(ellipseIn: CGRect(x: petalOffset, y: 0, width: petalWidth, height: rect.width / 2))
            let rotatedPetal = originalPetal.applying(position)
            path.addPath(rotatedPetal)
        }
        return path
    }
}

struct ColorCyclingCircle: View {
    var amount = 0.0
    var steps = 100
    
    var body: some View {
        ZStack {
            ForEach(0..<steps) { value in
                Circle()
                    .inset(by: Double(value))
                    .strokeBorder(
                        LinearGradient(
                            gradient: Gradient(colors: [
                                color(for: value, brightness: 1),
                                color(for: value, brightness: 0.5)
                            ]),
                            startPoint: UnitPoint.top,
                            endPoint: .bottom)
                    )
            }
        }
        .drawingGroup()
    }
    
    func color(for value: Int, brightness: Double) -> Color {
        var targetHue = Double(value) / Double(steps) + amount
        
        if targetHue > 1{
            targetHue -= 1
        }
        
        return Color(hue: targetHue, saturation: 1, brightness: brightness)
    }
}

struct ContentView: View {
    @State private var animationAmount = 1.0
    @State private var fillingArc = 0.0
    @Namespace private var animation
    
    @State private var petalOffser = -20.0
    @State private var petalWidth = 50.0
    
    @State private var colorCycle = 0.0
    
    var body: some View {
        VStack {
            ZStack {
//                Capsule()
//                    .strokeBorder(ImagePaint(image: Image("acapulco"), sourceRect: CGRect(x: 0, y: 0.25, width: 1, height: 1), scale: 0.3), lineWidth: 100)
//                    .frame(width: 350, height: 500)
//                    .opacity(0.5)
                
//                Circle()
//                    .strokeBorder(.ultraThinMaterial, lineWidth: 40)
//
//                Triangle()
//                    .stroke(.primary, style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round))
//                    .frame(width: 150, height: 150)
//                    .rotationEffect(Angle(degrees: animationAmount))
//                    .animation(.spring(response: 0.2, dampingFraction: 0.1, blendDuration: 10), value: animationAmount)
//
//                Arc(startAngle: .degrees(180), endAngle: .degrees(90), clockwise: true)
//                    .strokeBorder(.blue, lineWidth: 30)
//                    .rotationEffect(Angle(degrees: -animationAmount))
//                    .animation(.interactiveSpring(response: 1, dampingFraction: 0.5, blendDuration: 20), value: animationAmount)
//
//                Arc(startAngle: .zero, endAngle: .degrees(fillingArc), clockwise: true)
//                    .stroke(.purple, lineWidth: 10)
//                    .frame(width: 300, height: 300)
                
                ColorCyclingCircle(amount: colorCycle)
                
                Flower(petalOffset: petalOffser, petalWidth: petalWidth)
//                    .stroke(.pink, lineWidth: 1)
                    .fill(.ultraThinMaterial, style: FillStyle(eoFill: true))
                    .opacity(0.5)

                Button (action: {
                    withAnimation {
                        if fillingArc < 360 {
                            fillingArc += 30
                        } else {
                            fillingArc = 30
                        }
                        animationAmount += 30
                    }
                }) {

                    Text("PRESS ME NOW")
                        .frame(width: 140, height: 140)
                        .background(.yellow)
                        .clipShape(Circle())
                }

                .rotationEffect(Angle(degrees: animationAmount))
                .animation(.spring(response: 0.2, dampingFraction: 0.1, blendDuration: 10), value: animationAmount)
            }
            
            VStack {
                Text("Offset")
                Slider(value: $petalOffser, in: -40...40)
                    .padding(.horizontal)
                Text("Width")
                Slider(value: $petalWidth, in: 1...100)
                    .padding(.horizontal)
                Text("Color Cycle")
                Slider(value: $colorCycle)
                    .padding([.horizontal, .bottom])
            }
            .padding(.bottom)
        }
        .background(.purple)
        .ignoresSafeArea()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
