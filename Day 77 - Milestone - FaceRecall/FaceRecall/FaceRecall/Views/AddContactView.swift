//
//  AddContactView.swift
//  FaceRecall
//
//  Created by Maxim Datskiy on 10/19/23.
//

import CoreImage
import CoreImage.CIFilterBuiltins
import SwiftUI

struct AddContactView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.managedObjectContext) var moc
    
    let locationFetcher = LocationFetcher()
    
    @State private var image: Image?
    @State private var showingImagePicker = false
    @State private var showingPhotoNameEditor = false
    
    @State private var name: String = ""
    @State private var about: String = ""
    
    @State private var inputImage: UIImage?
    @State private var processedImage: UIImage?
    @State private var currentFilter: CIFilter = CIFilter()
    
    let context = CIContext()
    
    var body: some View {
        VStack {
            ZStack {
//                Circle()
                
                Image(systemName: "person.crop.circle")
                    .resizable()
                    .scaledToFit()
//                    .foregroundColor(.white)
//                    .frame(width: 100, height: 100)
                
                image?
                    .resizable()
                    .scaledToFill()
                
                
            }
            .clipShape(Circle())
            .frame(width: 150, height: 150)
            .onTapGesture(perform: tap)
            
            Button("Edit Image", action: tap)
                .buttonStyle(.borderedProminent)
            
            Form {
                TextField("Name", text: $name)
                
                TextField("About", text: $about)
            }
            
            VStack {
                Button("Start Tracking Location") {
                    self.locationFetcher.start()
                }

                Button("Read Location") {
                    if let location = self.locationFetcher.lastKnownLocation {
                        print("Your location is \(location)")
                    } else {
                        print("Your location is unknown")
                    }
                }
            }
            
            Button("Save") {
                // add user and save photo to FileManager
                let contact = Contact(context: moc)
                contact.name = name
                contact.about = about
                contact.image = UUID()
                
                saveContactImage(contact)
                try? moc.save()
                
                dismiss()
            }
                .buttonStyle(.borderedProminent)
            
            Spacer()
            
        }
        .padding()
        .onChange(of: inputImage) { loadImage() }
        .sheet(isPresented: $showingImagePicker) {
            ImagePicker(image: $inputImage)
        }
    }
    
    func tap() {
        showingImagePicker = true
    }
    
    func applyProcessing() {
        guard let outputImage = currentFilter.outputImage else { return }
        if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
            let uiImage = UIImage(cgImage: cgimg)
            image = Image(uiImage: uiImage)
            processedImage = uiImage
        }
    }
    
    func loadImage() {
        guard let inputImage = inputImage else { return }
        image = Image(uiImage: inputImage)
    }
    
    func saveContactImage(_ contact: Contact) {
        let imageURL = FileManager.documentsDirectory.appendingPathComponent(
            "img/\(String(describing: contact.image))"
        )
//        print(imageURL)
        
        if let jpegData = inputImage?.jpegData(compressionQuality: 0.8) {
            try? jpegData.write(to: imageURL, options: [.atomic, .completeFileProtection])
            print("Photo has been saved succesfully\n\n\n\n\n")
        } else {
            print("Can't save image to File Manager")
        }
    }
    
}

//#Preview {
//    AddContactView(contacts: $contacts)
//}
