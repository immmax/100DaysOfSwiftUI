//
//  ContentView.swift
//  Moonshot
//
//  Created by Maxim Datskiy on 6/15/23.
//

import SwiftUI

//struct CustomText: View {
//    let text: String
//
//    var body: some View {
//        Text(text)
//    }
//
//    init(_ text: String) {
//        print("Creating a new CustomText: \(text)")
//        self.text = text
//    }
//}

//struct User: Codable {
//    let name: String
//    let address: Address
//}
//
//struct Address : Codable {
//    let street: String
//    let city: String
//}

struct ContentView: View {
    let layout = [
        GridItem(.adaptive(minimum: 80, maximum: 120))
    ]
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: layout) {
                    ForEach(1..<300) { num in
                        ZStack {
                            Color(red: .random(in: 0...1), green: .random(in: 0...1), blue: .random(in: 0...1))
                                .clipShape(RoundedRectangle(cornerRadius: 14.0))
                            Image("apple")
                                .resizable()
                                .scaledToFit()
                                .clipShape(Circle())
                                .opacity(0.5)
                        }
                    }
                }
            }
            .navigationTitle("ScrollView")
            .padding(5)
        }
        
        
        
        
//        Button("Decode JSON") {
//            let input = """
//            {
//                "name": "Max Datskiy",
//                "address": {
//                    "street": "108 E.Fremont St.",
//                    "city": "O'Neill"
//                }
//            }
//            """
//            
//            let data = Data(input.utf8)
//            
//            if let user = try? JSONDecoder().decode(User.self, from: data) {
//                print(user.address.street)
//            }
//        }
//        .buttonStyle(.borderedProminent)
        
        //        NavigationView {
        //            List(1..<100) { row in
        //                NavigationLink {
        //                    Text("Details \(row)")
        //                } label: {
        //                    Text("Row \(row)")
        //                }
        //            }
        //            .navigationTitle("SwiftUI")
        //        }
        
//        GeometryReader { geo in
//            Image("example")
//                .resizable()
//                .scaledToFit()
//                .frame(width: geo.size.width * 0.9)
//                .frame(width: geo.size.width,
//                       height: geo.size.height)
//        }
        
        
//        NavigationView {
//            ScrollView() {
//                LazyVStack(spacing: 10) {
//                    ForEach(1..<100) {
//                        CustomText("Text \($0)")
//                            .font(.title)
//                    }
//                }
//                .frame(maxWidth: .infinity)
//            }
//        }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
