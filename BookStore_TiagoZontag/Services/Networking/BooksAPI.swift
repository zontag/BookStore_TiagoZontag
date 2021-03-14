//
//  BooksAPI.swift
//  BookStore_TiagoZontag
//
//  Created by Tiago Zontag on 13/03/21.
//

import Foundation

enum BooksAPI {
    case volumes(tags: [String], startIndex: Int, maxResults: Int)
}

extension BooksAPI: Target {

    var baseURL: String { "www.googleapis.com" }

    var path: String {
        switch self {
        case .volumes:
            return "/books/v1/volumes"
        }
    }

    var method: NetworkingMethod {
        switch self {
        case .volumes:
            return .get
        }
    }

    var queryParams: [String: String?] {
        switch self {
        case .volumes(let tags, let startIndex, let maxResults):
            return ["q": tags.joined(separator: ","),
                    "startIndex": String(startIndex),
                    "maxResults": String(maxResults)]
        }
    }
}
