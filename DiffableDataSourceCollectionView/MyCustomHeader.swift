//
//  MyCustomHeader.swift
//  DiffableDataSourceCollectionView
//
//  Created by Kai Chi Tsao on 2024/1/22.
//

import UIKit

class MyCustomHeader: UICollectionReusableView {
    static let identifier = "MyCustomHeader"

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .black
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(titleLabel)
        titleLabel.frame = bounds
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with title: String) {
        titleLabel.text = title
    }
}
