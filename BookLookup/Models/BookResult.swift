//
//  BookResult.swift
//  BookLookup
//
//  Created by Victor Hudson on 11/19/26.
//

import Foundation

struct BookResult: Decodable, Identifiable {
    // MARK: - Properties
    let key: String
    let title: String
    let authorNames: [String]?
    let firstPublishYear: Int?
    let coverID: Int?

    // MARK: - Computed Properties
    var id: String { key }

    // MARK: - Coding Keys
    enum CodingKeys: String, CodingKey {
        case key
        case title
        case authorNames = "author_name"
        case firstPublishYear = "first_publish_year"
        case coverID = "cover_i"
    }
}

