//
//  ProductCell.swift
//  01-open-market
//
//  Copyright (c) 2023 Jeremy All rights reserved.


import UIKit

final class ProductCell: UICollectionViewCell {
    private let imageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.cornerRadius = 15
        image.clipsToBounds = true
        return image
    }()
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = .preferredFont(forTextStyle: .headline)
        label.adjustsFontForContentSizeCategory = true
        return label
    }()
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .systemGray2
        return label
    }()
    private let stockLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    private let labelsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        return stackView
    }()
    private let totalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        combineViews()
        configureLayout()
        configureViewStyles()
        
        
        // TODO: Remove
        nameLabel.text = "CookieDog"
        stockLabel.text = "10"
        priceLabel.text = "100000.0$"
        imageView.image = UIImage(named: "cookieDog")?.resize(width: 50, height: 50)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        imageView.image = nil
    }
    
    // MARK: Privat Function(s)
    
    private func configureViewStyles() {
        contentView.backgroundColor = .systemFill
        contentView.layer.cornerRadius = 15
    }
    
    private func combineViews() {
        contentView.addSubview(totalStackView)
        [nameLabel, priceLabel, stockLabel].forEach { view in
            labelsStackView.addArrangedSubview(view)
        }
        [imageView, labelsStackView].forEach { view in
            totalStackView.addArrangedSubview(view)
        }
    }
    
    private func configureLayout() {
        NSLayoutConstraint.activate([
            totalStackView.leadingAnchor
                .constraint(
                    equalTo: contentView.leadingAnchor,
                    constant: 10
                ),
            totalStackView.topAnchor
                .constraint(
                    equalTo: contentView.topAnchor,
                    constant: 10
                ),
            totalStackView.trailingAnchor
                .constraint(
                    equalTo: contentView.trailingAnchor,
                    constant: -10
                ),
            totalStackView.bottomAnchor
                .constraint(
                    equalTo: contentView.bottomAnchor,
                    constant: -10
                ),
            imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor)
        ])
    }
}
