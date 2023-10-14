//
//  Result.swift
//  BucketList
//
//  Created by Maxim Datskiy on 10/14/23.
//

import Foundation

struct Result: Codable {
    let query: Query
}

struct Query: Codable {
    let pages: [Int: Page]
}

struct Page: Codable {
    let pageid: Int
    let title: String
    let terms: [String: [String]]?
}
