//
//  BookCellCollectionViewCell.swift
//  BookStore_TiagoZontag
//
//  Created by Tiago Zontag on 13/03/21.
//

import UIKit
import Kingfisher

class BookCollectionCellView: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!

    var viewModel: BookCollectionCellViewModeling? {
        didSet {
            self.bindViewModel()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentView.clipsToBounds = true
        self.contentView.layer.cornerRadius = 12
        self.contentView.layer.borderWidth = 1
        self.contentView.layer.borderColor = UIColor.systemGray6.cgColor
        self.contentView.backgroundColor = .systemGray6
    }

    private func bindViewModel() {
        guard let viewModel = self.viewModel else { return }
        viewModel.onAuthorChanged { [weak self] (author) in
            self?.authorLabel.text = author
        }
        viewModel.onTitleChanged { [weak self] (title) in
            self?.titleLabel.text = title
        }
        viewModel.onThumbnailChanged { [weak self] (url) in
            self?.imageView.kf.setImage(
                with: url,
                placeholder: #imageLiteral(resourceName: "BookPlaceholder"),
                options: [
                    .cacheOriginalImage,
                    .transition(.fade(0.25)),
                ])
        }
    }
}
