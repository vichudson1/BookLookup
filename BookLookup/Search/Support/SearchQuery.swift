//
//  SearchQuery.swift
//  BookLookup
//
//  Created by Victor Hudson on 11/20/26.
//

struct SearchQuery: Equatable {
    var searchTerm = ""
    var limit = 5

    static let limitOptions = [5, 10, 15, 20, 25]
}
