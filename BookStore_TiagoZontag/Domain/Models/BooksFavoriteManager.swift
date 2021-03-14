//
//  BooksFavoriteManager.swift
//  BookStore_TiagoZontag
//
//  Created by Tiago Zontag on 14/03/21.
//

import Foundation

protocol BooksFavoriteManaging {
    var books: [BookModel] { get }
    func update()
}

final class BooksFavoriteManager: BooksFavoriteManaging {

    var books: [BookModel] = []

    private let database: BookDatabase

    init(database: BookDatabase) {
        self.database = database
    }

    func update() {
        self.books = database.fetchAll()
    }

}
