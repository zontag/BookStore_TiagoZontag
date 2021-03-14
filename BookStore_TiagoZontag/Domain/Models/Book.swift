//
//  Book.swift
//  BookStore_TiagoZontag
//
//  Created by Tiago Zontag on 13/03/21.
//

import Foundation

protocol BookModel {
    var id: String { get }
    var title: String { get }
    var authors: [String] { get }
    var publisher: String? { get }
    var publishedDate: String? { get }
    var description: String { get }
    var smallThumbnail: URL? { get }
    var thumbnail: URL? { get }
    var forSale: String { get }
    var buyLink: URL? { get }
    var isFavorite: Bool { get set }
}

final class Book: BookModel {

    let id: String
    let title: String
    let authors: [String]
    let publisher: String?
    let publishedDate: String?
    let description: String
    let smallThumbnail: URL?
    let thumbnail: URL?
    let forSale: String
    let buyLink: URL?

    var isFavorite: Bool {
        get {
            database.contains(self.id)
        }
        set {
            if newValue {
                self.database.save(self)
            } else {
                self.database.delete(self)
            }
        }
    }

    private var database: BookDatabase

    init(id: String,
         title: String,
         authors: [String],
         publisher: String?,
         publishedDate: String?,
         description: String,
         smallThumbnail: URL?,
         thumbnail: URL?,
         forSale: String,
         buyLink: URL?,
         database: BookDatabase) {
        self.id = id
        self.title = title
        self.authors = authors
        self.publisher = publisher
        self.publishedDate = publishedDate
        self.description = description
        self.smallThumbnail = smallThumbnail
        self.thumbnail = thumbnail
        self.forSale = forSale
        self.buyLink = buyLink
        self.database = database
    }

}
