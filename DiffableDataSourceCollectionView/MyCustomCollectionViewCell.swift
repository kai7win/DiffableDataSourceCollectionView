//
//  MyCustomCollectionViewCell.swift
//  DiffableDataSourceCollectionView
//
//  Created by Kai Chi Tsao on 2024/1/22.
//

import UIKit

class MyCustomCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "MyCustomCollectionViewCell"
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .black
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(titleLabel)
        contentView.backgroundColor = .yellow
        contentView.layer.cornerRadius = frame.size.height / 2
        contentView.layer.masksToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        titleLabel.frame = contentView.bounds
    }

    func configure(with title: String) {
        titleLabel.text = title
    }
}

