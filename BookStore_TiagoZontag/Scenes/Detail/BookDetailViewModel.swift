//
//  BookDetailViewModel.swift
//  BookStore_TiagoZontag
//
//  Created by Tiago Zontag on 14/03/21.
//

import Foundation

protocol BookDetailViewModeling {
    var thumbnailURL: URL? { get }
    var title: String { get }
    var authors: String { get }
    var description: String { get }
    var buyButtonTitle: String { get }
    var buyButtonVisibility: Bool { get }
    var favButtonTitle: String { get }
    var isFavorite: Bool { get set }
    var buyLink: URL? { get }
}

final class BookDetailViewModel: BookDetailViewModeling {

    var thumbnailURL: URL?
    var title: String
    var authors: String
    var description: String
    var buyButtonTitle: String
    var buyButtonVisibility: Bool
    var favButtonTitle: String = ""
    var buyLink: URL?

    var isFavorite: Bool {
        didSet {
            if oldValue != isFavorite {
                self.changeFavoriteState()
            }
        }
    }


    private let isFavoriteTitle = "Remove from favorites"
    private let isNotFavoriteTitle = "Save as favorite"
    private var book: BookModel

    init(book: BookModel) {
        self.book = book
        self.thumbnailURL = book.thumbnail
        self.title = book.title
        self.authors = book.authors.joined(separator: "; ")
        self.description = book.description
        self.buyButtonTitle = "Buy"
        self.buyButtonVisibility = book.forSale != "NOT_FOR_SALE"
        self.isFavorite = book.isFavorite
        self.setFavoriteButtonTitle()
        self.buyLink = book.buyLink
    }

    private func changeFavoriteState() {
        self.setFavoriteButtonTitle()
        self.book.isFavorite = self.isFavorite
    }

    private func setFavoriteButtonTitle() {
        self.favButtonTitle = self.isFavorite ? isFavoriteTitle : isNotFavoriteTitle
    }

}
