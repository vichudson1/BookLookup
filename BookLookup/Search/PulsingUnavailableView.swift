//
//  PulsingUnavailableView.swift
//  BookLookup
//
//  Created by Victor Hudson on 11/23/26.
//

import SwiftUI

struct PulsingUnavailableView: View {
    // MARK: - Properties
    let title: String
    let systemImage: SystemImage
    let description: String

    // MARK: - View
    var body: some View {
        ContentUnavailableView {
            Label(title, systemImage: systemImage.rawValue)
                .symbolEffect(
                    .pulse.wholeSymbol,
                    options: .repeat(.periodic(3, delay: 1.0)))
        } description: {
            Text(description)
        }
    }
}

#Preview {
    PulsingUnavailableView(
        title: "Sample",
        systemImage: .search,
        description: "Description")
}
