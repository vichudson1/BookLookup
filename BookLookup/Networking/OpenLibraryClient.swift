//
//  OpenLibraryClient.swift
//  BookLookup
//
//  Created by Victor Hudson on 11/19/26.
//

import Foundation

struct OpenLibraryClient {
    /// Searches Open Library for books that match a query.
    ///
    /// Sends one request to the Open Library search API and asks only for
    /// the fields that ``BookResult`` decodes. A blank query returns an empty
    /// array right away, without a network call.
    ///
    /// - Parameters:
    ///   - query: The text to search for, such as a title or an author.
    ///   - limit: The most results to return. The search may return fewer.
    /// - Returns: The matching books, or an empty array if `query` is blank.
    /// - Throws: A `URLError` if the request fails or the server returns an error status,
    ///   or a `DecodingError` if the response doesn't match ``BookResult``.
    func searchBooks(matching query: String, limit: Int) async throws -> [BookResult] {
        guard let baseURL = URL(string: "https://openlibrary.org/search.json") else {
            throw URLError(.badURL)
        }
        guard !query.isBlank else {
            return []
        }

        let fields = BookResult.CodingKeys.allCases.map(\.rawValue).joined(separator: ",")
        let url = baseURL.appending(queryItems: [
            URLQueryItem(name: "q", value: query),
            URLQueryItem(name: "limit", value: "\(limit)"),
            URLQueryItem(name: "fields", value: fields),
        ])

        var request = URLRequest(url: url)
        request.setValue("BookLookup/1.0 (vichudson1@gmail.com)", forHTTPHeaderField: "User-Agent")

        let (data, response) = try await URLSession.shared.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse,
            (200...299).contains(httpResponse.statusCode)
        else {
            throw URLError(.badServerResponse)
        }

        let searchResponse = try JSONDecoder().decode(SearchResponse.self, from: data)

        return searchResponse.docs
    }
}
