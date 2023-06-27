//
//  Day-43-View.swift
//  Drawing
//
//  Created by Maxim Datskiy on 6/26/23.
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

struct Day_43_View: View {
    @State private var animationAmount = 1.0
    @State private var fillingArc = 0.0
    @Namespace private var animation
    
    var body: some View {
        VStack {
            ZStack {
                
                
                Circle()
                    .strokeBorder(.ultraThinMaterial, lineWidth: 40)

                Triangle()
                    .stroke(.primary, style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round))
                    .frame(width: 150, height: 150)
                    .rotationEffect(Angle(degrees: animationAmount))
                    .animation(.spring(response: 0.2, dampingFraction: 0.1, blendDuration: 10), value: animationAmount)

                Arc(startAngle: .degrees(180), endAngle: .degrees(90), clockwise: true)
                    .strokeBorder(.blue, lineWidth: 30)
                    .rotationEffect(Angle(degrees: -animationAmount))
                    .animation(.interactiveSpring(response: 1, dampingFraction: 0.5, blendDuration: 20), value: animationAmount)

                Arc(startAngle: .zero, endAngle: .degrees(fillingArc), clockwise: true)
                    .stroke(.green, lineWidth: 10)
                    .frame(width: 300, height: 300)

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
        }
        .background(.purple)
        .opacity(0.6)
        .ignoresSafeArea()
    }
}

struct Day_43_View_Previews: PreviewProvider {
    static var previews: some View {
        Day_43_View()
    }
}
