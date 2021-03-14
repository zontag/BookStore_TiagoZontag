//
//  Mappers.swift
//  BookStore_TiagoZontag
//
//  Created by Tiago Zontag on 14/03/21.
//

import Foundation
import CoreData

// MARK: - VolumeResponse
extension VolumeResponse {

    func asBookModel(database: BookDatabase) -> BookModel {
        Book(id: self.id ?? "",
             title: self.volumeInfo?.title ?? "",
             authors: self.volumeInfo?.authors ?? [],
             publisher: self.volumeInfo?.publisher ?? "",
             publishedDate: self.volumeInfo?.publishedDate ?? "",
             description: self.volumeInfo?.description ?? "",
             smallThumbnail: URL(string: self.volumeInfo?.imageLinks?.smallThumbnail ?? ""),
             thumbnail: URL(string: self.volumeInfo?.imageLinks?.thumbnail ?? ""),
             forSale: self.saleInfo?.saleability ?? "",
             buyLink: URL(string: self.saleInfo?.buyLink ?? ""),
             database: database)
    }

}

// MARK: - BookModel
extension BookModel {

    @discardableResult
    func asBookEntity(context: NSManagedObjectContext) -> BookEntity {
        let entity = BookEntity(context: context)
        entity.id = self.id
        entity.title = self.title
        entity.authors = self.authors
        entity.publisher = self.publisher
        entity.publishedDate = self.publishedDate
        entity.infoDescription = self.description
        entity.smallThumbnail = self.smallThumbnail
        entity.thumbnail = self.thumbnail
        entity.forSale = self.forSale
        entity.buyLink = self.buyLink
        return entity
    }
    
}

// MARK: - BookEntity
extension BookEntity {

    func asBookModel(database: BookDatabase) -> BookModel {
        Book(id: self.id ?? "",
             title: self.title ?? "",
             authors: self.authors ?? [],
             publisher: self.publisher,
             publishedDate: self.publishedDate,
             description: self.infoDescription ?? "",
             smallThumbnail: self.smallThumbnail,
             thumbnail: self.thumbnail,
             forSale: self.forSale ?? "",
             buyLink: self.buyLink,
             database: database)
    }
    
}
