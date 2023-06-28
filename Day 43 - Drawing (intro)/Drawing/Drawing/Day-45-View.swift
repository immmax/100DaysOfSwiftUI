//
//  Day-45-View.swift
//  Drawing
//
//  Created by Maxim Datskiy on 6/26/23.
//

import SwiftUI

struct Lesson1: View {
    @State private var amount = 0.5

    var body: some View {
        VStack {
            Image("DmitroGordon")
                .resizable()
                .scaledToFit()
                .opacity(amount)
                .saturation(amount)
                .blur(radius: (1 - amount) * 20)
//                .colorMultiply(Color(red: 1, green: 0.8431, blue: 0))
                .clipShape(Circle())
                .padding(.top)
            
            
            ZStack {
                Circle()
                    .fill(Color(red: 1, green: 0, blue: 0))
                    .frame(width: 200 * amount)
                    .offset(x: -50, y: -80)
                    .blendMode(.screen)
                
                Circle()
                    .fill(Color(red: 0, green: 1, blue: 0))
                    .frame(width: 200 * amount)
                    .offset(x: 50, y: -80)
                    .blendMode(.screen)
                
                Circle()
                    .fill(Color(red: 0, green: 0, blue: 1))
                    .frame(width: 200 * amount)
                    .blendMode(.screen)
            }
            .frame(width: 300, height: 300)
            
            Text("Прозрачный Гордон")
                .foregroundColor(.purple)
                .font(.title)
            Slider(value: $amount)
                .padding([.bottom, .horizontal])
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.black)
        .ignoresSafeArea()
    }
    
    init(amount: Double = 0.5) {
        self.amount = amount
    }
}

struct Lesson2: View {
    
    struct Trapezoid: Shape {
        var insetAmount: Double
        
        var animatableData: Double {
            get { insetAmount }
            set { insetAmount = newValue }
        }
        
        func path(in rect: CGRect) -> Path {
            var path = Path()
            
            path.move (to: CGPoint(x: 0, y: rect.maxY))
            path.addLine (to: CGPoint(x: insetAmount, y: rect .minY))
            path.addLine(to: CGPoint(x: rect.maxX - insetAmount, y: rect.minY))
            path.addLine(to: CGPoint (x: rect.maxX, y: rect.maxY))
            path.addLine (to: CGPoint(x: 0, y: rect.maxY))
           
            return path
        }
    }
    
    @State private var insetAmount = 50.0
    @State private var radius = 20.0
    @State private var trapR = 1.0
    @State private var trapG = 1.0
    @State private var trapB = 1.0
    @State private var gordonR = 1.0
    @State private var gordonG = 1.0
    @State private var gordonB = 1.0
    
    var body: some View {
        VStack {
            Spacer()
            Trapezoid(insetAmount: insetAmount)
                .foregroundColor(
                    Color(
                        red: trapR,
                        green: trapG,
                        blue: trapB))
                .frame(width: 200, height: 100)
                .padding(.bottom)
                .onTapGesture {
                    withAnimation {
                        insetAmount = Double.random(in: 10...90)
                        trapR = Double.random(in: 0...1)
                        trapG = Double.random(in: 0...1)
                        trapB = Double.random(in: 0...1)
                    }
                }
            Spacer()
            Image("DmitroGordon")
                .resizable()
                .colorMultiply(
                    Color(
                        red: gordonR,
                        green: gordonG,
                        blue: gordonB))
                .scaledToFit()
                .frame(width: radius)
                .clipShape(Circle())
//                .rotationEffect(.degrees(radius * Double.random(in: -2...2)))
                .onTapGesture {
                    withAnimation {
                        radius = Double.random(in: 50...200)
                        gordonR = Double.random(in: 0...1)
                        gordonG = Double.random(in: 0...1)
                        gordonB = Double.random(in: 0...1)
                    }
                }
            Spacer()
        }
    }
}

struct Lesson3: View {
    @State private var rows = 4
    @State private var columns = 8
    
    struct Checkerboard: Shape {
        var rows: Int
        var columns: Int
        
        var animatableData: AnimatablePair<Double, Double> {
            get {
                AnimatablePair(Double(rows), Double(columns))
            }
            
            set {
                rows = Int(newValue.first)
                columns = Int(newValue.second)
            }
        }
        
        func path(in rect: CGRect) -> Path {
            var path = Path()
            
            let rowSize = rect.height / Double(rows)
            let columnSize = rect.width / Double(columns)
            
            for row in 0..<rows {
                for column in 0..<columns {
                    if (row + column).isMultiple(of: 2) {
                        let startX = columnSize * Double(column)
                        let startY = rowSize * Double(row)
                        
                        let rect = CGRect(x: startX, y: startY, width: columnSize, height: rowSize)
                        path.addRect(rect)
                    }
                }
            }
            return path
        }
    }
    
    var body: some View {
        Checkerboard(rows: rows, columns: columns)
            .onTapGesture {
                withAnimation (.linear(duration: 3)) {
                    rows = 8
                    columns = 16
                }
            }
    }
}

struct Lesson4: View {
    
    struct Spytograph: Shape {
        let innerRadius: Int
        let outerRadius: Int
        let distance: Int
        let amount: Double
        
        func gcd(_ a: Int, _ b :Int) -> Int {
            var a = a
            var b = b
            
            while b != 0 {
                let temp = b
                b = a % b
                a = temp
            }
            
            return a
        }
        
        func path(in rect: CGRect) -> Path {
            let divisor = gcd(outerRadius, innerRadius)
            
            let outerRadius = Double(self.outerRadius)
            let innerRadius = Double(self.innerRadius)
            let distance = Double(self.distance)
            let difference = innerRadius - outerRadius
            let endPoint = ceil(2 * Double.pi * outerRadius / Double(divisor)) * amount
            
            var path = Path()
            for theta in stride(from: 0, through: endPoint, by: 0.01) {
                var x = difference * cos(theta) + distance * cos(distance / outerRadius * theta)
                var y = difference * sin(theta) - distance * sin(distance / outerRadius * theta)
                
                x += rect.width / 2
                y += rect.height / 2
                
                if theta == 0 {
                    path.move(to: CGPoint(x: x, y: y))
                } else {
                    path.addLine(to: CGPoint(x: x, y: y))
                }
            }
            return path
        }
    }
    
    @State private var innerRadius = 125.0
    @State private var outerRadius = 75.0
    @State private var distance = 25.0
    @State private var amount = 1.0
    @State private var hue = 0.6
    
    var body: some View
    {
        VStack(spacing: 0) {
            Spacer()
            
            Spytograph(innerRadius: Int(innerRadius), outerRadius: Int(outerRadius), distance: Int(distance), amount: amount)
                .stroke(Color(hue: hue, saturation: 1, brightness: 1), lineWidth: 1)
                .frame(width: 300, height: 300)
            
            Spacer()
            
            Group {
                Text("Inner Raduis: \(Int(innerRadius))")
                Slider(value: $innerRadius, in: 10...150, step: 1)
                    .padding([.horizontal, .bottom])
                
                Text("Outer Raduis: \(Int(outerRadius))")
                Slider(value: $outerRadius, in: 10...150, step: 1)
                    .padding([.horizontal, .bottom])
                
                Text("Distance: \(Int(distance))")
                Slider(value: $distance, in: 1...150, step: 1)
                    .padding([.horizontal, .bottom])
                
                Text("Amount: \(amount, format: .number.precision(.fractionLength(2)))")
                Slider(value: $amount)
                    .padding([.horizontal, .bottom])
                
                Text("Color")
                Slider(value: $hue)
                    .padding(.horizontal)
            }
        }
    }
}

struct Day_45_View: View {
    
    var body: some View {
        NavigationStack {
            Group {
                Image("DmitroGordon")
                    .resizable()
                    .scaledToFit()
                    .clipShape(Circle())
                    .frame(height: 250)
            }
        }
        .navigationTitle("Drawing - Day 3")
        .toolbar {
            ToolbarItemGroup(placement: .bottomBar) {
                ScrollView {
                    HStack {
                        ForEach(1..<5, id: \.self) { number in
                            NavigationLink {
                                if number == 1 { Lesson1() }
                                else if number == 2 { Lesson2() }
                                else if number == 3 { Lesson3() }
                                else if number == 4 { Lesson4() }
                                else { Text("I have no idea what are you looking for. Sorry.") }
                            } label: {
                                Text("Ex. \(number)")
                                    .padding()
                                    .frame(width: 80, height: 40)
                                    .background(.gray)
                                    .foregroundColor(.cyan)
                                    .clipShape(RoundedRectangle(cornerRadius: 20))
                            }
                            .padding(.bottom)

                        }
                    }
                }
            }
        }
        .ignoresSafeArea()
    }
//    }
}

struct Day_45_View_Previews: PreviewProvider {
    static var previews: some View {
        Day_45_View()
    }
}
