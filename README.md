# BookLookup

A SwiftUI book search app. Type a title or author and get real results from the [Open Library](https://openlibrary.org) API.

Built for Weekend 3 of my iOS Catch-Up Plan: getting back into iOS development with modern SwiftUI. The goal this weekend is **networking and Swift concurrency**, done the current way.

> **Status:** Project set up. Search comes next.

## Why Open Library?

- **Free,** with no API key or sign-up
- **Real book data:** titles, authors, years, and covers
- **Useful later:** it can power real book lookups in [Shelf](https://github.com/vichudson1/Shelf)'s Add Book screen

## The plan

| Swift piece | Used for |
| --- | --- |
| `async`/`await` + `URLSession.shared.data(from:)` | Fetching search results |
| `Codable` | Decoding the JSON into Swift types |
| `.task` | Loading data when a view appears |
| `.refreshable` | Pull to refresh |
| `@MainActor`, `Sendable` | Keeping UI updates safe under Swift 6 strict concurrency |
| Loading, error, and empty states | Handling slow networks, failures, and no results |

No completion handlers. No `DispatchQueue.main.async`.

## Requirements

- Xcode with the iOS 27 SDK
- iOS 27 or later (iPhone or iPad)
- An internet connection

## Run it

1. Clone the repo.
2. Open `BookLookup.xcodeproj` in Xcode.
3. Pick a simulator or your iPhone.
4. Press **Cmd + R**.

## Roadmap

- [x] Project setup
- [ ] Decode Open Library search results with `Codable`
- [ ] Search screen with a live results list
- [ ] Loading, error, and empty states
- [ ] Pull to refresh, and clean handling when offline
