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
        List {
            Section("Search Term") {
                TextField("Search Term", text: $model.query.searchTerm)
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
        .task(id: model.query) {
            await model.search()
        }
    }
}

#Preview {
    SearchView()
}
