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
    var errorMessage: String?

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
            try await Task.sleep(for: delay)
            books = try await client.searchBooks(
                matching: query.searchTerm,
                limit: query.limit
            )
            errorMessage = nil
        } catch is CancellationError {
            // Query was changed
        } catch let error as URLError where error.code == .cancelled {
            // Request cancelled by new query
        } catch {
            errorMessage = error.localizedDescription
            books = []
            print("Fetch failed: \(error)")
        }
    }
}
