//
//  BooksViewModel.swift
//  BookStore_TiagoZontag
//
//  Created by Tiago Zontag on 13/03/21.
//

import Foundation

protocol BooksViewModeling {
    var title: String { get }
    var books: [BookModel] { get }
    var isFavorites: Bool { get set }
    func updateFavorites()
    func onBooksChanged(_ action: @escaping Action1<[BookModel]>)
    func prefetch(row: Int)
    func search(text: String)
}

final class BooksViewModel: BooksViewModeling {

    private var searchTags: [String] = []
    private var onBooksChangedAction: Action1<[BookModel]>?

    private(set) var books: [BookModel] = [] {
        didSet {
            self.onBooksChangedAction?(books)
        }
    }

    var isFavorites: Bool = false {
        didSet {
            if isFavorites {
                booksFavoriteManager.update()
                self.books = booksFavoriteManager.books
            } else {
                self.fetchBooks(self.searchTags)
            }
        }
    }

    var title: String = "Books"
    let booksManager: BooksSearchable
    let booksFavoriteManager: BooksFavoriteManaging

    init(booksManager: BooksSearchable,
         booksFavoriteManager: BooksFavoriteManaging) {
        self.booksManager = booksManager
        self.booksFavoriteManager = booksFavoriteManager
        self.booksManager.onBooksChanged { (books) in
            self.books = books
        }
    }

    func onBooksChanged(_ action: @escaping Action1<[BookModel]>) {
        onBooksChangedAction = action
    }

    func prefetch(row: Int) {
        if row == self.books.count - 1 {
            self.booksManager.fetchNext()
        }
    }

    func search(text: String) {
        let tags = text.components(separatedBy: CharacterSet.alphanumerics.inverted
                                    .union(CharacterSet.whitespacesAndNewlines))
        self.searchTags = tags
        self.fetchBooks(tags)
    }

    func updateFavorites() {
        booksFavoriteManager.update()
        if isFavorites {
            self.books = booksFavoriteManager.books
        }
    }

    private func fetchBooks(_ tags: [String]) {
        self.booksManager.search(tags: tags)
    }

}
