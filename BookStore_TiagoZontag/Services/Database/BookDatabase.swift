//
//  BookDatabase.swift
//  BookStore_TiagoZontag
//
//  Created by Tiago Zontag on 13/03/21.
//

import Foundation
import CoreData

protocol BookDatabase {
    func save(_ book: BookModel)
    func delete(_ book: BookModel)
    func contains(_ bookID: String) -> Bool
    func fetchAll() -> [BookModel]
}

final class CoreDataBookManager: BookDatabase {

    private let persistenceManager: PersistenceManaging
    private var container: NSPersistentContainer { persistenceManager.persistentContainer }
    private var viewContext: NSManagedObjectContext { container.viewContext }

    init(persistenceManager: PersistenceManaging = PersistenceManager.shared) {
        self.persistenceManager = persistenceManager
    }

    func save(_ book: BookModel) {
        let fetchRequest: NSFetchRequest<BookEntity> = BookEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id==%@", book.id)
        if let result = try? viewContext.fetch(fetchRequest) {
            result.forEach(viewContext.delete)
        }
        book.asBookEntity(context: self.viewContext)
        persistenceManager.saveContext()
    }

    func delete(_ book: BookModel) {
        let fetchRequest: NSFetchRequest<BookEntity> = BookEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id==%@", book.id)
        if let result = try? viewContext.fetch(fetchRequest) {
            result.forEach(viewContext.delete)
        }
        persistenceManager.saveContext()
    }

    func contains(_ bookID: String) -> Bool {
        let fetchRequest: NSFetchRequest<BookEntity> = BookEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id==%@", bookID)
        guard let result = try? viewContext.fetch(fetchRequest) else  { return false }
        return result.count > 0
    }

    func fetchAll() -> [BookModel] {
        let fetchRequest: NSFetchRequest<BookEntity> = BookEntity.fetchRequest()
        guard let result = try? viewContext.fetch(fetchRequest) else  { return [] }
        return result.map { $0.asBookModel(database: self) }
    }

}
