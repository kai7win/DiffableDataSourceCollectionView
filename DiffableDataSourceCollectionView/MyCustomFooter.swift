//
//  MyCustomFooter.swift
//  DiffableDataSourceCollectionView
//
//  Created by Kai Chi Tsao on 2024/1/22.
//

import UIKit

class MyCustomFooter: UICollectionReusableView {
    static let identifier = "MyCustomFooter"

    private let label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .black
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(label)
        label.frame = bounds
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with text: String) {
        label.text = text
    }
}
