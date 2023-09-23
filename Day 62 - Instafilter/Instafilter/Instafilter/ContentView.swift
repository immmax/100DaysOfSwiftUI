//
//  ContentView.swift
//  Instafilter
//
//  Created by Maxim Datskiy on 9/11/23.
//

import CoreImage
import CoreImage.CIFilterBuiltins
import SwiftUI

struct ContentView: View {
    @State private var image: Image?
    @State private var filterIntensity = 0.5
    @State private var filterRadius = 100.0
    @State private var filterScale = 100.0
<<<<<<< Updated upstream
=======
    @State private var filterAmount = 50.0
>>>>>>> Stashed changes
    
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    @State private var processedImage: UIImage?
    
    @State private var currentFilter: CIFilter = CIFilter.sepiaTone()
    
    let context = CIContext()
    
    @State private var showingFilterSheet = false
    
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
                
                
                if currentFilter.inputKeys.contains(kCIInputIntensityKey){
                    HStack {
                        Text("Intensity")
                        Slider(value: $filterIntensity, in: 0...1)
                            .onChange(of: filterIntensity) {_ in applyProcessing() }
                    }
                    .padding(.vertical)
                }
                
                if currentFilter.inputKeys.contains(kCIInputRadiusKey) {
                    HStack {
                        Text("Radius")
                        Slider(value: $filterRadius, in: 0...200)
                            .onChange(of: filterRadius) {_ in applyProcessing() }
                    }
                    .padding(.vertical)
                }
                
                if currentFilter.inputKeys.contains(kCIInputScaleKey) {
                    HStack {
                        Text("Scale")
                        Slider(value: $filterScale, in: 0.5...200)
                            .onChange(of: filterScale) {_ in applyProcessing() }
                    }
                    .padding(.vertical)
                }
                
<<<<<<< Updated upstream
=======
                if currentFilter.inputKeys.contains(kCIInputAmountKey) {
                    HStack {
                        Text("Scale")
                        Slider(value: $filterAmount, in: 0.5...200)
                            .onChange(of: filterAmount) {_ in applyProcessing() }
                    }
                    .padding(.vertical)
                }
                
>>>>>>> Stashed changes
                HStack {
                    Button("Select filter", action: selectFilter)
                        .buttonStyle(.bordered)
                        .tint(.blue)
                    
                    Spacer()
                    
                    Button("Save", action: save)
                        .buttonStyle(.borderedProminent)
                        .tint(image == nil ? .none : .cyan)
                        .disabled(image == nil)
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
        .confirmationDialog("Select the filter", isPresented: $showingFilterSheet) {
            Button("Crystaillize")      { setFilter(CIFilter.crystallize()) }
            Button("Edges")             { setFilter(CIFilter.edges()) }
            Button("Gaussian Blur")     { setFilter(CIFilter.gaussianBlur()) }
            Button("Pixellate")         { setFilter(CIFilter.pixellate()) }
            Button("Sepia Tone")        { setFilter(CIFilter.sepiaTone()) }
            Button("Unsharp Mask")      { setFilter(CIFilter.unsharpMask()) }
            Button("Vignette")          { setFilter(CIFilter.vignette()) }
            Button("Pointillize")       { setFilter(CIFilter.pointillize()) }
            Button("Vibrance")          { setFilter(CIFilter.vibrance()) }
<<<<<<< Updated upstream
=======
//            Button()
>>>>>>> Stashed changes
            Button("Cancel", role: .cancel) { }
        }
    }
    
    func tap() {
        showingImagePicker = true
    }
    
    func applyProcessing() {
        let inputKeys = currentFilter.inputKeys
        
        if inputKeys.contains(kCIInputIntensityKey) {
            currentFilter.setValue(filterIntensity, forKey: kCIInputIntensityKey)
        }
        if inputKeys.contains(kCIInputRadiusKey) {
            currentFilter.setValue(filterRadius, forKey: kCIInputRadiusKey)
        }
        if inputKeys.contains(kCIInputScaleKey) {
            currentFilter.setValue(filterScale, forKey: kCIInputScaleKey)
        }
        
        guard let outputImage = currentFilter.outputImage else { return }
        if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
            let uiImage = UIImage(cgImage: cgimg)
            image = Image(uiImage: uiImage)
            processedImage = uiImage
        }
    }
    
    func loadImage() {
        guard let inputImage = inputImage else { return }
        
        let beginImage = CIImage(image: inputImage)
        currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
        
        applyProcessing()
    }
    
    func selectFilter() {
        showingFilterSheet = true
    }
    
    func setFilter(_ filter: CIFilter) {
        currentFilter = filter
        loadImage()
    }
    
    func save() {
        guard let processedImage = processedImage else { return }
        
        let imageSaver = ImageSaver()
        
        imageSaver.successHandler = {
            print("Success!")
        }
        
        imageSaver.errorHandler = {
            print("Oops! \($0.localizedDescription)")
        }
        
        imageSaver.writeToPhotoAlbum(image: processedImage)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
