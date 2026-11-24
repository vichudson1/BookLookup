//
//  SearchView.swift
//  BookLookup
//
//  Created by Victor Hudson on 11/18/26.
//

import SwiftUI

struct SearchView: View {
    // MARK: - @State properties
    @State private var model = SearchViewModel()

    // MARK: - View Body
    var body: some View {
        NavigationStack {
            List {
                Section("Number of Results") {
                    Picker("Result Limit", selection: $model.query.limit) {
                        ForEach(SearchQuery.limitOptions, id: \.self) { limit in
                            Text(limit, format: .number)
                                .tag(limit)
                        }
                    }
                    .pickerStyle(.segmented)
                }

                Section("Results") {
                    ForEach(model.books) { book in
                        VStack(alignment: .leading) {
                            Text(book.title)
                            Text(book.authorNames?.joined(separator: ", ") ?? "")
                                .foregroundStyle(.secondary)
                        }
                    }
                }
            }
            .navigationTitle("Book Lookup")
            .searchable(text: $model.query.searchTerm, prompt: "Title or author")
            .overlay {
                if let errorMessage = model.errorMessage {
                    PulsingUnavailableView(
                        title: "Couldn't Load Results",
                        systemImage: .error,
                        description: errorMessage)
                } else if model.query.searchTerm.isBlank {
                    PulsingUnavailableView(
                        title: "Search For Books",
                        systemImage: .search,
                        description: "Search for books by title or author.")
                } else if model.books.isEmpty {
                    PulsingUnavailableView(
                        title: "No Matches Found",
                        systemImage: .emptySearch,
                        description: "No books match \"\(model.query.searchTerm)\"")
                }
            }
            .task(id: model.query) {
                await model.search()
            }
        }
    }
}

#Preview {
    SearchView()
}
