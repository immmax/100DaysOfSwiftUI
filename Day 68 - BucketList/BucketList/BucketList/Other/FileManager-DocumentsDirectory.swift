//
//  FileManager-DocumentsDirectory.swift
//  BucketList
//
//  Created by Maxim Datskiy on 10/15/23.
//

import Foundation

extension FileManager {
    static var documentsDirectory: URL {
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return path[0]
    }
}
