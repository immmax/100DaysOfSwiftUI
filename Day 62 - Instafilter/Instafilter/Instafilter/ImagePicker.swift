//
//  ImagePicker.swift
//  Instafilter
//
//  Created by Maxim Datskiy on 9/12/23.
//

import PhotosUI
import SwiftUI

struct ImagePicker: UIViewControllerRepresentable{
    func makeUIViewController(context: Context) -> PHPickerViewController {
        var config = PHPickerConfiguration()
        config.filter = .images
        
        let picker = PHPickerViewController(configuration: config)
        return picker
    }
    
    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {
        
    }

//    Строка ниже используется для того, чтобы появилась ошибка, в которой можно нажать Fix,
//    что приведёт к автоматическому появлению методов make и update. Затем эту строку можно удалить.
//    typealias UIViewControllerType = PHPickerViewController
}
