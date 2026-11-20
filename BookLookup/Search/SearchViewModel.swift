//
//  SearchViewModel.swift
//  BookLookup
//
//  Created by Victor Hudson on 11/20/26.
//

import Observation
import Foundation

@Observable
final class SearchViewModel {
    // MARK: - Properties
    var searchTerm = ""
    var books: [BookResult] = []
    var errorMessage: String?

    // MARK: - Private Properties
    private let client = OpenLibraryClient()

    // MARK: - Methods
    func search() async {
        do {
            books = try await client.searchBooks(matching: searchTerm)
            errorMessage = nil
        } catch {
            errorMessage = error.localizedDescription
            print("Fetch failed: \(error)")
        }
    }
}
