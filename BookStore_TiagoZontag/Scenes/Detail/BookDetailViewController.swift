//
//  BookDetailViewController.swift
//  BookStore_TiagoZontag
//
//  Created by Tiago Zontag on 14/03/21.
//

import UIKit
import Kingfisher

class BookDetailViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorsLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var buyButton: UIButton!
    @IBOutlet weak var favButton: UIButton!

    var viewModel: BookDetailViewModeling?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.imageView.layer.borderWidth = 1
        self.imageView.layer.borderColor = UIColor.systemGray6.cgColor
        self.imageView.clipsToBounds = true
        self.imageView.layer.cornerRadius = 12
        self.setupViewModel()
    }

    private func setupViewModel() {
        self.title = self.viewModel?.title
        self.titleLabel.text = self.viewModel?.title
        self.authorsLabel.text = self.viewModel?.authors
        self.descriptionLabel.text = self.viewModel?.description
        self.buyButton.setTitle(self.viewModel?.buyButtonTitle, for: .normal)
        self.buyButton.isEnabled = self.viewModel?.buyButtonVisibility ?? false
        self.favButton.setTitle(self.viewModel?.favButtonTitle, for: .normal)
        self.imageView.kf.setImage(
            with: self.viewModel?.thumbnailURL,
            placeholder: #imageLiteral(resourceName: "BookPlaceholder"),
            options: [
                .cacheOriginalImage,
                .transition(.fade(0.25)),
            ])
    }
    
    @IBAction func buyButtonAction(_ sender: Any) {
        if let url = self.viewModel?.buyLink {
            self.router?.routeTo(.safari(url))
        }
    }

    @IBAction func favoriteButtonAction(_ sender: Any) {
        self.viewModel?.isFavorite.toggle()
        self.favButton.setTitle(self.viewModel?.favButtonTitle, for: .normal)
    }
}
