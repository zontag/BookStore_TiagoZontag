//
//  Response.swift
//  BookStore_TiagoZontag
//
//  Created by Tiago Zontag on 13/03/21.
//

import Foundation

// MARK: - PagedResultResponse
struct PagedResultResponse<Element>: Decodable where Element: Decodable {
    let kind: String
    let totalItems: Int
    let items: [Element]
}
