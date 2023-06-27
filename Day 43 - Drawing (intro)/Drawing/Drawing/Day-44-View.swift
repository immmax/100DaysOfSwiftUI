//
//  Day-44-View.swift
//  Drawing
//
//  Created by Maxim Datskiy on 6/26/23.
//

import SwiftUI

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

struct Day_44_View: View {
    @State private var petalOffser = -20.0
    @State private var petalWidth = 50.0
    
    @State private var colorCycle = 0.0
    
    var body: some View {
        VStack {
            ZStack {
                Capsule()
                    .strokeBorder(ImagePaint(image: Image("acapulco"), sourceRect: CGRect(x: 0, y: 0.25, width: 1, height: 1), scale: 0.3), lineWidth: 100)
                    .frame(width: 350, height: 500)
                    .opacity(0.7)
                
                ColorCyclingCircle(amount: colorCycle)
                    .frame(width: 250)
                
                Flower(petalOffset: petalOffser, petalWidth: petalWidth)
//                    .stroke(.pink, lineWidth: 1)
                    .fill(.ultraThinMaterial, style: FillStyle(eoFill: true))
                    .opacity(0.7)
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
    }
}

struct Day_44_View_Previews: PreviewProvider {
    static var previews: some View {
        Day_44_View()
    }
}
