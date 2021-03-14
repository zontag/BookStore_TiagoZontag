//
//  BooksManager.swift
//  BookStore_TiagoZontag
//
//  Created by Tiago Zontag on 13/03/21.
//

import Foundation

protocol BooksSearchable {
    func onBooksChanged(_ action: @escaping Action1<[BookModel]>)
    func onFailure(_ action: @escaping Action1<Error>)
    func fetchNext()
    func search(tags: [String])
}

final class BooksSearchManager: BooksSearchable {

    private var onBooksChangedAction: Action1<[BookModel]>?
    private var onFailureAction: Action1<Error>?

    private let maxResults = 20
    private var currentIndex = 0
    private var totalItems = 0

    private var tags: [String] = [] {
        didSet {
            self.items = []
            self.totalItems = 0
        }
    }

    private var items: [BookModel] = [] {
        didSet {
            self.currentIndex = items.count
            self.onBooksChangedAction?(items)
        }
    }

    let networkService: NetworkService
    let database: BookDatabase

    init(networkService: NetworkService, database: BookDatabase) {
        self.networkService = networkService
        self.database = database
    }

    func fetchNext() {
        if self.items.count == self.totalItems { return }
        networkService.volumes(tags: self.tags, startIndex: self.currentIndex, maxResults: self.maxResults, completion: self.searchCompletionHandler)
    }

    func search(tags: [String]) {
        self.tags = tags
        networkService.volumes(tags: tags, startIndex: self.currentIndex, maxResults: self.maxResults, completion: self.searchCompletionHandler)
    }

    func onBooksChanged(_ action: @escaping Action1<[BookModel]>) {
        self.onBooksChangedAction = action
    }

    func onFailure(_ action: @escaping Action1<Error>) {
        self.onFailureAction = action
    }

    private func searchCompletionHandler(_ result: Result<PagedResultResponse<VolumeResponse>, Error>) {
        switch result {
        case .success(let pagedResultResponse):
            self.totalItems = pagedResultResponse.totalItems
            let books = pagedResultResponse.items.map{ $0.asBookModel(database: self.database) }
            self.items.append(contentsOf: books)
        case .failure(let error):
            self.onFailureAction?(error)
        }
    }

}
