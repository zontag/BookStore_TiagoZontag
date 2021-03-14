//
//  BooksNetworkService.swift
//  BookStore_TiagoZontag
//
//  Created by Tiago Zontag on 13/03/21.
//

import Foundation

protocol NetworkService {
    func volumes(tags: [String], startIndex: Int, maxResults: Int,
                 completion: @escaping Action1<Result<PagedResultResponse<VolumeResponse>, Error>>)
}

final class BooksNetworkService: NetworkService {

    private let requestable: TargetRequestable

    init(requestable: TargetRequestable) {
        self.requestable = requestable
    }

    func volumes(tags: [String], startIndex: Int, maxResults: Int,
                 completion: @escaping Action1<Result<PagedResultResponse<VolumeResponse>, Error>>) {
        requestable.request(BooksAPI.volumes(tags: tags, startIndex: startIndex, maxResults: maxResults), completion: completion)
    }
}
