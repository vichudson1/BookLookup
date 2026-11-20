//
//  ContentView.swift
//  BookLookup
//
//  Created by Victor Hudson on 11/18/26.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Text("Loading Books")
            .task {
                guard let baseURL = URL(string: "https://openlibrary.org/search.json") else {
                    return
                }
                let url = baseURL.appending(queryItems: [
                    URLQueryItem(name: "q", value: "dune"),
                    URLQueryItem(name: "limit", value: "5"),
                ])

                do {
                    let (data, _) = try await URLSession.shared.data(from: url)
                    let response = try JSONDecoder().decode(SearchResponse.self, from: data)
                    for book in response.docs {
                        print(book.title)
                        print(book.authorNames ?? "No Authors")
                    }
                } catch {
                    print("Fetch failed: \(error)")
                }
            }
    }
}

#Preview {
    ContentView()
}
