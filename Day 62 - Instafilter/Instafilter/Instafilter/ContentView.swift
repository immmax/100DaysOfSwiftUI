//
//  ContentView.swift
//  Instafilter
//
//  Created by Maxim Datskiy on 9/11/23.
//

import CoreImage
import CoreImage.CIFilterBuiltins
import PhotosUI
import StoreKit
import SwiftUI

struct ContentView: View {
    @State private var selectedItem: PhotosPickerItem?
    @State private var processedImage: Image?
    
    @AppStorage("filterCount") var filterCount = 0
    @Environment(\.requestReview) var requestReview
    
    @State private var filterIntensity = 0.5
    @State private var filterRadius = 100.0
    @State private var filterScale = 100.0
    @State private var filterAmount = 50.0
    
    @State private var showingFilterSheet = false
    @State private var currentFilter: CIFilter = CIFilter.sepiaTone()
    let context = CIContext()
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                
                PhotosPicker(selection: $selectedItem, matching: .all(of: [.images, .not(.screenshots)])) {
                    if let processedImage {
                        processedImage
                            .resizable()
                            .scaledToFit()
                    } else {
                        ContentUnavailableView("No Picture", systemImage: "photo.badge.plus", description: Text("Tap to import a photo"))
                    }
                }
//                .buttonStyle(.plain)
                
                Spacer()
                
                if currentFilter.inputKeys.contains(kCIInputIntensityKey) {
                    HStack {
                        Text("Intensity")
                        Slider(value: $filterIntensity, in: 0...1)
                            .onChange(of: filterIntensity, applyProcessing)
                    }
                    .padding(.vertical)
                }
                
                if currentFilter.inputKeys.contains(kCIInputRadiusKey) {
                    HStack {
                        Text("Radius")
                        Slider(value: $filterRadius, in: 0...200)
                            .onChange(of: filterRadius, applyProcessing)
                    }
                    .padding(.vertical)
                }
                
                if currentFilter.inputKeys.contains(kCIInputScaleKey) {
                    HStack {
                        Text("Scale")
                        Slider(value: $filterScale, in: 0.5...200)
                            .onChange(of: filterScale, applyProcessing)
                    }
                    .padding(.vertical)
                }
                
                HStack {
                    Button("Select filter", action: changeFilter)
                        .buttonStyle(.bordered)
                        .tint(.blue)
                        .disabled(selectedItem == nil)
                    
                    Spacer()
                    
                    if let processedImage {
                        ShareLink(item: processedImage, preview: SharePreview("Instafilter image", image: processedImage))
                    }
                }
            }
            .padding([.horizontal, .bottom])
            .navigationTitle("Instafilter")
        }
        .onChange(of: selectedItem, loadImage)
        
        .confirmationDialog("Select a filter", isPresented: $showingFilterSheet) {
            Button("Crystallize")   { setFilter(CIFilter.crystallize()) }
            Button("Edges")         { setFilter(CIFilter.edges()) }
            Button("Gaussian Blur") { setFilter(CIFilter.gaussianBlur()) }
            Button("Pixellate")     { setFilter(CIFilter.pixellate()) }
            Button("Sepia Tone")    { setFilter(CIFilter.sepiaTone()) }
            Button("Unsharp Mask")  { setFilter(CIFilter.unsharpMask()) }
            Button("Vignette")      { setFilter(CIFilter.vignette()) }
            Button("Pointillize")   { setFilter(CIFilter.pointillize()) }
            Button("Vibrance")      { setFilter(CIFilter.vibrance()) }
            Button("Cancel", role: .cancel) { }
        }
    }
    
    func loadImage() {
        Task {
            guard let imageData = try await selectedItem?.loadTransferable(type: Data.self) else { return }
            guard let inputImage = UIImage(data: imageData) else { return }
            
            let beginImage = CIImage(image: inputImage)
            currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
            applyProcessing()
        }
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
        guard let cgimg = context.createCGImage(outputImage, from: outputImage.extent) else { return }
        
        let uiImage = UIImage(cgImage: cgimg)
        processedImage = Image(uiImage: uiImage)
    }
    
    func changeFilter() {
        showingFilterSheet = true
    }
    
    @MainActor func setFilter(_ filter: CIFilter) {
        currentFilter = filter
        loadImage()
        
        filterCount += 1
        if filterCount >= 25 {
            requestReview()
        }
    }
}

#Preview {
    ContentView()
}
