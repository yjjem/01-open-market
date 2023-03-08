//
//  NameableTextFieldView.swift
//  01-open-market
//
//  Copyright (c) 2023 Jeremy All rights reserved.


import UIKit

final class NameableTextFieldView: UIView {
    
    // MARK: View(s)
    
    private let nameLabel: UILabel = {
        let label: UILabel = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let textField: UITextField = {
        let textField: UITextField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .systemGray5
        textField.layer.cornerRadius = 15
        textField.leftView = UIView(frame: .init(x: 0, y: 0, width: 15, height: 0))
        textField.leftViewMode = .always
        return textField
    }()
    
    var isEditable: Bool = false {
        didSet {
            textField.isEnabled = isEditable
        }
    }
    
    var text: String = "" {
        didSet {
            textField.text = text
        }
    }
    
    // MARK: Initialization
    
    init(name: String, placeHolder: String? = nil) {
        super.init(frame: .init())
        self.nameLabel.text = name
        textField.isEnabled = isEditable
        if let placeHolder = placeHolder {
            textField.placeholder = placeHolder
        }
        performViewConfiguration()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Private Function(s)
    
    private func performViewConfiguration() {
        combineViews()
        configureConstraints()
    }
    
    private func combineViews() {
        addSubview(nameLabel)
        addSubview(textField)
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            nameLabel.widthAnchor.constraint(equalToConstant: 80),
            nameLabel.heightAnchor.constraint(equalTo: heightAnchor),
            nameLabel.topAnchor.constraint(equalTo: topAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
        ])
        
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: topAnchor),
            textField.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: 10),
            textField.trailingAnchor.constraint(equalTo: trailingAnchor),
            textField.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
