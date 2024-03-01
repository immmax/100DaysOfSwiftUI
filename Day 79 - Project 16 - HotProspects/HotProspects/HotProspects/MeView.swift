//
//  MeView.swift
//  HotProspects
//
//  Created by Maxim Datskiy on 11/20/23.
//

import CoreImage
import CoreImage.CIFilterBuiltins
import SwiftUI

struct MeView: View {
    @AppStorage("name") private var name = "Anonimous"
    @AppStorage("email") private var email = "you@yoursite.com"
    @State private var qrCode = UIImage()
    
    let context = CIContext()
    let filter = CIFilter.qrCodeGenerator()
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Name", text: $name)
                    .textContentType(.name) // allow auto-complete
                    .font(.title)
                
                TextField("Email", text: $email)
                    .textContentType(.emailAddress)
                    .font(.title)
                
                Image(uiImage: qrCode)
                    .resizable()
                    .interpolation(.none)
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .contextMenu {
                        ShareLink(item: Image(uiImage: qrCode), preview: SharePreview("My QR Code", image: Image(uiImage: qrCode)))
                        //                        Button {
                        //                            let imageSaver = ImageSaver()
                        //                            imageSaver.writeToPhotoAlbum(image: qrCode)
                        //                        } label: {
                        //                            Label("Save to Photos", systemImage: "square.and.arrow.down")
                        //                        }
                    }
                    .onAppear(perform: updateCode)
                    .onChange(of: name, updateCode)
                    .onChange(of: email, updateCode)
            }
            .navigationTitle("Your QR-code")
        }
    }
    
    func updateCode() {
        qrCode = generateQRCode(from: "\(name)\n\(email)")
    }
    
    func generateQRCode(from string: String) -> UIImage {
        filter.message = Data(string.utf8)
        if let outputImage = filter.outputImage {
            if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
                return UIImage(cgImage: cgimg)
            }
        }
        return UIImage(systemName: "xmark.circle") ?? UIImage()
    }
}

#Preview {
    MeView()
}
