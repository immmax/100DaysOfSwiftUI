//
//  Day-46-View.swift
//  Drawing
//
//  Created by Maxim Datskiy on 6/26/23.
//

import SwiftUI

struct Arrow: Shape {
    var lineThickness: Double
    
    var animatableData: Double {
        get { lineThickness }
        set { lineThickness = newValue }
    }
    
    func path(in rect: CGRect) -> Path {
        //more code to come
        var path = Path()
        
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY / 3))
        path.addLine(to: CGPoint(x: rect.maxX / 3, y: rect.maxY / 3))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX / 3 * 2, y: rect.maxY / 3))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY / 3))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
        
        return path
    }
    
    
}

struct ColorCyclingRectangle: View {
    var amount = 0.0
    var gradientStartX = 0.0
    var gradientStartY = 0.0
    var gradientEndX = 0.0
    var gradientEndY = 0.0
    
    var steps = 100
    
    var body: some View {
        ZStack {
            ForEach(0..<steps) { value in
                RoundedRectangle(cornerRadius: 14)
                    .inset(by: Double(value))
                    .strokeBorder(
                        LinearGradient(
                            gradient: Gradient(colors: [
                                color(for: value, brightness: 1),
                                color(for: value, brightness: 0.5)
                            ]),
                            startPoint: UnitPoint(x: gradientStartX,
                                                  y: gradientStartY),
                            endPoint: UnitPoint(x: gradientEndX,
                                                y: gradientEndY))
                    )
            }
        }
        .drawingGroup()
    }
    
    func color(for value: Int, brightness: Double) -> Color {
        var targetHue = Double(value) / Double(steps) + amount
        
        if targetHue > 1 {
            targetHue -= 1
        }
        
        return Color(hue: targetHue, saturation: 1, brightness: brightness)
    }
}

struct Day_46_View: View {
    @State private var lineThickness = 25.0
    @State private var angle = 0.0
    @State private var color: Color = .cyan
    
    @State private var colorCycle = 0.0
    @State private var gradientStartX = 0.0
    @State private var gradientStartY = 0.0
    @State private var gradientEndX = 1.0
    @State private var gradientEndY = 1.0
    
    var body: some View {
        VStack {
            Spacer()
            Arrow(lineThickness: lineThickness)
                .stroke(color, style: StrokeStyle(lineWidth: lineThickness,
                                                  lineCap: .round,
                                                  lineJoin: .round))
                .padding([.vertical, .horizontal])
                .frame(width: 200, height: 300)
                .rotationEffect(Angle(degrees: angle))
                .onTapGesture {
                    withAnimation {
                        lineThickness = Double.random(in: 1...30)
                        angle = angle + Double.random(in: -90...90)
                        color = Color(
                            red: Double.random(in: 0...1),
                            green: Double.random(in: 0...1),
                            blue: Double.random(in: 0...1))
                    }
                }
                
            Spacer()
            ColorCyclingRectangle(amount: colorCycle,
                                  gradientStartX: gradientStartX,
                                  gradientStartY: gradientStartY,
                                  gradientEndX: gradientEndX,
                                  gradientEndY: gradientEndY)
                .padding(.horizontal)
                .onTapGesture {
                    withAnimation {
                        gradientStartX = Double.random(in: 0...1);
                        gradientStartY = Double.random(in: 0...1);
                        gradientEndX = Double.random(in: 0...1);
                        gradientEndY = Double.random(in: 0...1)
                    }
                }
            
            Text("Line Thickness")
            Slider(value: $lineThickness, in: 10...70)
                .padding([.horizontal, .bottom])
            Slider(value: $colorCycle)
                .padding([.horizontal, .bottom])
        }
            
    }
}

struct Day_46_View_Previews: PreviewProvider {
    static var previews: some View {
        Day_46_View()
    }
}
