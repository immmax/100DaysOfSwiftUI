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

//struct Lesson3: View {
//
//    var body: some View {
//
//    }
//}


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
//                                else if number == 3 { ContextMenu() }
                                else { Text("to be continued...") }
                            } label: {
                                Text("Ex. \(number)")
                                    .padding()
                                    .frame(width: 80, height: 40)
                                    .background(.gray)
                                    .foregroundColor(.red)
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
