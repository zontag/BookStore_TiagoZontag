//
//  MainNavigationController.swift
//  BookStore_TiagoZontag
//
//  Created by Tiago Zontag on 13/03/21.
//

import UIKit
import SafariServices

class MainNavigationController: UINavigationController, Router {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupBooksViewController()
    }

    private func setupBooksViewController() {
        guard let booksViewController = self.storyboard?.instantiateViewController(identifier: "BooksViewController") as? BooksViewController
        else { return }
        let networkService = BooksNetworkService(requestable: URLSession.shared)
        let database = CoreDataBookManager()
        let booksSearchManager = BooksSearchManager(networkService: networkService, database: database)
        let booksFavoriteManager = BooksFavoriteManager(database: database)
        let viewModel = BooksViewModel(booksManager: booksSearchManager, booksFavoriteManager: booksFavoriteManager)
        booksViewController.viewModel = viewModel
        setViewControllers([booksViewController], animated: false)
    }

    func routeTo(_ route: Route) {
        switch route {
        case .detail(let book):
            if let vc = storyboard?.instantiateViewController(identifier: "BookDetailViewController") as? BookDetailViewController {
                let viewModel = BookDetailViewModel(book: book)
                vc.viewModel = viewModel
                self.show(vc, sender: nil)
            }
        case .safari(let url):
            let vc = SFSafariViewController(url: url)
            self.present(vc, animated: true, completion: nil)
        }
    }
}
