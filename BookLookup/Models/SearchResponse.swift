//
//  SearchResponse.swift
//  BookLookup
//
//  Created by Victor Hudson on 11/19/26.
//

import Foundation

struct SearchResponse: Decodable {
    // MARK: - Properties
    let docs: [BookResult]
}
