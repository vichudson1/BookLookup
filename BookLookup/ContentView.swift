//
//  ContentView.swift
//  BookLookup
//
//  Created by Victor Hudson on 11/18/26.
//

import SwiftUI

struct ContentView: View {
    @State private var books: [BookResult] = []
    @State private var searchTerm: String = "Dune"

    var body: some View {
        List {
            Section("Search Term") {
                TextField("Search Term", text: $searchTerm)
            }
            Section("Results") {
                ForEach(books) { book in
                    VStack(alignment: .leading) {
                        Text(book.title)
                        Text(book.authorNames?.joined(separator: ", ") ?? "")
                            .foregroundStyle(.secondary)
                    }
                }
            }
        }
        .task(id: searchTerm) {
            do {
                books = try await OpenLibraryClient().searchBooks(matching: searchTerm)
            } catch {
                print("Fetch failed: \(error)")
            }
        }
    }
}

#Preview {
    ContentView()
}
