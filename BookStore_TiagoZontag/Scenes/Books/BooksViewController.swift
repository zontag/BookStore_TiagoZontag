//
//  BooksViewController.swift
//  BookStore_TiagoZontag
//
//  Created by Tiago Zontag on 13/03/21.
//

import UIKit

class BooksViewController: UICollectionViewController {

    @IBOutlet weak var bookmarkButton: UIBarButtonItem!

    // MARK: - Public Properties
    var viewModel: BooksViewModeling?

    // MARK: - Private Properties
    private let itemsPerRow: CGFloat = 2

    private var cellSize: CGSize {
        guard let layout = collectionViewLayout as? UICollectionViewFlowLayout else {
            return .zero
        }

        let paddingSpace =
            layout.sectionInset.left
            + layout.sectionInset.right
            + (layout.minimumInteritemSpacing * (itemsPerRow - 1))

        let availableWidth = collectionView.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        return CGSize(width: widthPerItem, height: widthPerItem * 1.6)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.bookmarkButton.tintColor = .systemGray
        self.collectionView.prefetchDataSource = self
        self.setupViewModel()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.viewModel?.updateFavorites()
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        coordinator.animate(alongsideTransition: { _ in self.collectionView.collectionViewLayout.invalidateLayout() },
                            completion: nil)
    }

    private func setupViewModel() {
        self.title = viewModel?.title
        self.viewModel?.onBooksChanged({ [weak self] _ in
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        })
        self.viewModel?.search(text: "ios")
    }

    @IBAction func onFavoritesAction(_ sender: Any) {
        guard var viewModel = self.viewModel else { return }
        viewModel.isFavorites.toggle()

        self.bookmarkButton.tintColor = viewModel.isFavorites ? .systemBlue : .systemGray
    }

}

// MARK: - Collection Delegate
extension BooksViewController {

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.viewModel?.books.count ?? 0
    }

    override func collectionView(_ collectionView: UICollectionView,
                                 cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? BookCollectionCellView
        else {
            preconditionFailure()
        }

        if cell.viewModel == nil {
            cell.viewModel = BookCollectionCellViewModel()
        }

        if let book = self.viewModel?.books[indexPath.row] {
            cell.viewModel?.setBook(book)
        }

        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.collectionView.deselectItem(at: indexPath, animated: true)
        if let book = viewModel?.books[indexPath.row] {
            self.router?.routeTo(.detail(book))
        }
    }

}

// MARK: - UICollectionViewDataSourcePrefetching
extension BooksViewController: UICollectionViewDataSourcePrefetching {

    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        if let row = indexPaths.last?.row {
            viewModel?.prefetch(row: row)
        }
    }

}

// MARK: - UICollectionViewDelegateFlowLayout
extension BooksViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return self.cellSize
    }

}
