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
        label.textAlignment = .left
        label.font = .preferredFont(forTextStyle: .headline)
        label.adjustsFontForContentSizeCategory = true
        return label
    }()
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    private let stockLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        return label
    }()
    private let labelsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.layoutMargins = UIEdgeInsets(
            top: 20,
            left: 10,
            bottom: 20,
            right: 10
        )
        stackView.isLayoutMarginsRelativeArrangement = true
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
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        imageView.image = nil
        nameLabel.text = nil
        priceLabel.text = nil
        stockLabel.text = nil
    }

    // MARK: Function(s)
    
    func setUpWith(product: Product) {
        imageView.setImage(with: product.thumbnail)
        nameLabel.text = product.name
        priceLabel.text = "가격: \(String(product.price)) \(product.currency.rawValue)"
        stockLabel.text = "수량: \(String(product.stock))"
    }
    
    // MARK: Privat Function(s)
    
    private func configureViewStyles() {
        contentView.backgroundColor = .tertiarySystemFill
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
            imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor),
        ])
    }
}
