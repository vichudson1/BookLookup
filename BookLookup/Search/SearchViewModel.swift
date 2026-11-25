//
//  SearchViewModel.swift
//  BookLookup
//
//  Created by Victor Hudson on 11/20/26.
//

import Foundation
import Observation

@Observable
final class SearchViewModel {
    // MARK: - Properties
    var query = SearchQuery()
    var books: [BookResult] = []
    var searchState: SearchState = .idle

    // MARK: - Private Properties
    private let client = OpenLibraryClient()
    private let delay: Duration

    // MARK: - Init
    init(delay: Duration = .milliseconds(400)) {
        self.delay = delay
    }

    // MARK: - Methods
    func search() async {
        do {
            books = []
            searchState = .loading
            try await Task.sleep(for: delay)
            books = try await client.searchBooks(
                matching: query.searchTerm,
                limit: query.limit
            )
            if query.searchTerm.isBlank {
                searchState = .idle
            } else if books.isEmpty {
                searchState = .noResults(term: query.searchTerm)
            } else {
                searchState = .results
            }
        } catch is CancellationError {
            // Query was changed
        } catch let error as URLError where error.code == .cancelled {
            // Request cancelled by new query
        } catch {
            searchState = .failed(error: error)
        }
    }
}
