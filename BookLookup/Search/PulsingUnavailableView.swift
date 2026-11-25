//
//  PulsingUnavailableView.swift
//  BookLookup
//
//  Created by Victor Hudson on 11/23/26.
//

import SwiftUI

struct PulsingUnavailableView: View {
    // MARK: - Properties
    let configuration: OverlayViewConfiguration

    // MARK: - View
    var body: some View {
        ContentUnavailableView {
            Label(configuration.title, systemImage: configuration.systemImage.rawValue)
                .symbolEffect(
                    .pulse.wholeSymbol,
                    options: .repeat(.periodic(3, delay: 1.0)))
        } description: {
            Text(configuration.description)
        }
    }
}

#Preview {
    PulsingUnavailableView(
        configuration: OverlayViewConfiguration(
            title: "Sample",
            systemImage: .idle,
            description: "Description"
        )
    )
}
