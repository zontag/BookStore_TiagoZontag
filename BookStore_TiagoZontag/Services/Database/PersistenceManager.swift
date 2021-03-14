//
//  PersistenceManager.swift
//  BookStore_TiagoZontag
//
//  Created by Tiago Zontag on 14/03/21.
//

import Foundation
import CoreData
import UIKit

protocol PersistenceManaging {
    var persistentContainer: NSPersistentContainer { get }
    func saveContext()
}

class PersistenceManager: PersistenceManaging {

    static let shared: PersistenceManager = { .init() }()

    let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "BookStore_TiagoZontag")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    private init() {
        let center = NotificationCenter.default
        let notification = UIApplication.willResignActiveNotification

        center.addObserver(forName: notification, object: nil, queue: nil) { [weak self] _ in
            guard let self = self else { return }
            self.saveContext()
        }
    }

    func saveContext () {
        if self.persistentContainer.viewContext.hasChanges {
            try? self.persistentContainer.viewContext.save()
        }
    }
}
