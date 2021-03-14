//
//  BookCollectionCellViewModel.swift
//  BookStore_TiagoZontag
//
//  Created by Tiago Zontag on 13/03/21.
//

import Foundation

protocol BookCollectionCellViewModeling {
    func setBook(_ book: BookModel)
    func onTitleChanged(_ action: @escaping Action1<String>)
    func onAuthorChanged(_ action: @escaping Action1<String>)
    func onThumbnailChanged(_ action: @escaping Action1<URL?>)
}

final class BookCollectionCellViewModel: BookCollectionCellViewModeling {

    private var onTitleChangedAction: Action1<String>?
    private var onAuthorChangedAction: Action1<String>?
    private var onThumbnailChangedAction: Action1<URL?>?

    func setBook(_ book: BookModel) {
        self.onTitleChangedAction?(book.title)
        self.onAuthorChangedAction?(book.authors.joined(separator: "; "))
        self.onThumbnailChangedAction?(book.smallThumbnail)
    }

    func onTitleChanged(_ action: @escaping Action1<String>) {
        self.onTitleChangedAction = action
    }

    func onAuthorChanged(_ action: @escaping Action1<String>) {
        self.onAuthorChangedAction = action
    }

    func onThumbnailChanged(_ action: @escaping Action1<URL?>) {
        self.onThumbnailChangedAction = action
    }

}
