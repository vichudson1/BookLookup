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
                    ContentUnavailableView {
                        Label(
                            "Couldn't Load Results", systemImage: "exclamationmark.magnifyingglass"
                        )
                        .symbolEffect(
                            .pulse.wholeSymbol,
                            options: .repeat(.periodic(3, delay: 1.0)))
                    } description: {
                        Text(errorMessage)
                    }
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
