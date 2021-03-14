//
//  VolumeResponse.swift
//  BookStore_TiagoZontag
//
//  Created by Tiago Zontag on 13/03/21.
//

import Foundation

// MARK: - VolumeResponse
struct VolumeResponse: Decodable {
    let kind: String?
    let id: String?
    let etag: String?
    let selfLink: String?
    let volumeInfo: VolumeInfoResponse?
    let saleInfo: SaleInfoResponse?
}

// MARK: - SaleInfo
struct SaleInfoResponse: Decodable {
    let country: String?
    let saleability: String?
    let isEbook: Bool?
    let listPrice: SaleInfoListPriceResponse?
    let retailPrice: SaleInfoListPriceResponse?
    let buyLink: String?
}

// MARK: - SaleInfoListPrice
struct SaleInfoListPriceResponse: Decodable {
    let amount: Double
    let currencyCode: String
}

// MARK: - VolumeInfo
struct VolumeInfoResponse: Decodable {
    let title: String
    let authors: [String]?
    let publisher: String?
    let publishedDate: String?
    let description: String?
    let readingModes: ReadingModesResponse?
    let pageCount: Int?
    let printType: String?
    let categories: [String]?
    let maturityRating: String?
    let allowAnonLogging: Bool?
    let contentVersion: String?
    let imageLinks: ImageLinksResponse?
    let previewLink: String?
    let infoLink: String?
    let canonicalVolumeLink: String?
    let subtitle: String?
}

// MARK: - ImageLinks
struct ImageLinksResponse: Decodable {
    let smallThumbnail: String?
    let thumbnail: String?
}

// MARK: - ReadingModes
struct ReadingModesResponse: Decodable {
    let text: Bool
    let image: Bool
}
