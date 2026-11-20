//
//  OpenLibraryClient.swift
//  BookLookup
//
//  Created by Victor Hudson on 11/19/26.
//

import Foundation

struct OpenLibraryClient {
    func searchBooks(matching query: String) async throws -> [BookResult] {
        guard let baseURL = URL(string: "https://openlibrary.org/search.json") else {
            throw URLError(.badURL)
        }
        let url = baseURL.appending(queryItems: [
            URLQueryItem(name: "q", value: query),
            URLQueryItem(name: "limit", value: "5"),
        ])

        let (data, _) = try await URLSession.shared.data(from: url)
        let response = try JSONDecoder().decode(SearchResponse.self, from: data)

        return response.docs
    }
}

