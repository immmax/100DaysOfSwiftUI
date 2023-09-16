//
//  ContentView.swift
//  Instafilter
//
//  Created by Maxim Datskiy on 9/11/23.
//

import SwiftUI

struct ContentView: View {
    @State private var image: Image?
    @State private var filterIntensity = 0.3
    
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    
    var body: some View {
        NavigationView {
            VStack {
                ZStack {
                    Rectangle()
                        .fill(.secondary)
                        .cornerRadius(15)
                    
                    Text("Tap to select a picture")
                        .foregroundColor(.white)
                        .font(.headline)
                    
                    image?
                        .resizable()
                        .scaledToFit()
                }
                .onTapGesture(perform: tap)
                
                
                HStack {
                    Text("Intensity")
                    Slider(value: $filterIntensity, in: 0...1)
                }
                .padding(.vertical)
                
                HStack {
                    Button("Apply filter", action: applyFilter)
                        .buttonStyle(.bordered)
                        .tint(.blue)
                    
                    Spacer()
                    
                    Button("Save", action: save)
                        .buttonStyle(.borderedProminent)
                        .tint(.mint)
                }
            }
            .padding([.horizontal, .bottom])
            .navigationTitle("Instafilter")
            .navigationBarTitleDisplayMode(.inline)
        }
        .onChange(of: inputImage) { _ in loadImage() }
        .sheet(isPresented: $showingImagePicker) {
            ImagePicker(image: $inputImage)
        }
    }
    
    func loadImage(){
        guard let inputImage = inputImage else { return }
        image = Image(uiImage: inputImage)
    }
    
    func tap() {
        showingImagePicker = true
    }
    
    func save() {
        
    }
    
    func applyFilter() {
        
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
