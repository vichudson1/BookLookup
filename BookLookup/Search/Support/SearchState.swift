//
//  SearchState.swift
//  BookLookup
//
//  Created by Victor Hudson on 11/24/26.
//

import Foundation

enum SearchState {
    case idle
    case loading
    case noResults(term: String)
    case failed(error: Error)
    case results
}

extension SearchState {
    var overlayConfiguration: OverlayViewConfiguration? {
        switch self {
        case .idle:
            OverlayViewConfiguration(
                title: "Search For Books",
                systemImage: .idle,
                description: "Search for books by title or author.")
        case .loading:
            OverlayViewConfiguration(
                title: "Searching For Books",
                systemImage: .loading,
                description: "Searching for books.")
        case .noResults(let term):
            OverlayViewConfiguration(
                title: "No Matches Found",
                systemImage: .emptySearch,
                description: "No books match \"\(term)\"")
        case .failed(let error):
            OverlayViewConfiguration(
                title: "Couldn't Load Results",
                systemImage: .error,
                description: error.localizedDescription)
        case .results:
            nil
        }
    }
}
