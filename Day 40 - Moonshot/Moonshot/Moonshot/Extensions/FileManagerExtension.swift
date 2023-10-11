//
//  FileManagerExtesion.swift
//  Moonshot
//
//  Created by Maxim Datskiy on 10/7/23.
//

import Foundation

extension FileManager {
    func copyFilesFromBundle(_ files: [String]) {
        for file in files {
            guard let path = Bundle.main.url(forResource: file, withExtension: nil) else {
                print("File \(file) not found in Bundle")
                return
            }
            guard let data = try? Data(contentsOf: path) else {
                fatalError("Failed to load \(file) from data.")
            }
            
            do {
                try data.write(to: Self.default.getDocumentsDirectory().appendingPathComponent(file))
            } catch {
                print("Unable to copy file \(file) from bundle")
            }
        }
    }
    
    func getDocumentsDirectory() -> URL {
        return Self.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    }
    
    func decode<T: Codable>(_ file: String) -> T {
        // Get file url
        let url = Self.default.getDocumentsDirectory().appendingPathComponent(file)
        
        // Create and set decoder
        let decoder = JSONDecoder()
        let formatter = DateFormatter()
        formatter.dateFormat = "y-MM-dd"
        decoder.dateDecodingStrategy = .formatted(formatter)
        
        // Get data to decode
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load \(file) from file manager.")
        }
        
        // Decode data
        guard let decoded = try? decoder.decode(T.self, from: data) else {
            fatalError("Failed to decode \(file) from file manager.")
        }
        
        return decoded
    }
}
