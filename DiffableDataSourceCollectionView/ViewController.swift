//
//  ViewController.swift
//  DiffableDataSourceCollectionView
//
//  Created by Kai Chi Tsao on 2024/1/22.
//

import UIKit

class ViewController: UIViewController {
    
    private var collectionView: UICollectionView!
    private var dataSource: UICollectionViewDiffableDataSource<Int, Item>!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        configureDataSource()
        applyInitialSnapshots()
        
        //模擬3秒後從API拿新數據
        fetchDataFromServer { [weak self] newItems in
            self?.updateSnapshot(with: newItems)
        }
    }
    private func configureCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        let width = (view.frame.size.width - 40) / 3 // 40 = 10*4 (左右間隙)
        layout.itemSize = CGSize(width: width, height: width)
        
       
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .white
        collectionView.register(MyCustomCollectionViewCell.self, forCellWithReuseIdentifier: MyCustomCollectionViewCell.identifier)
        collectionView.register(MyCustomHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: MyCustomHeader.identifier)
        collectionView.register(MyCustomFooter.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: MyCustomFooter.identifier)
        collectionView.delegate = self
        view.addSubview(collectionView)
    }
    
    private func configureDataSource() {
        
        dataSource = UICollectionViewDiffableDataSource<Int, Item>(collectionView: collectionView) {
            (collectionView, indexPath, item) -> UICollectionViewCell? in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyCustomCollectionViewCell.identifier, for: indexPath) as? MyCustomCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.configure(with: "\(indexPath.row)") 
            return cell
        }
        
        dataSource.supplementaryViewProvider = { (collectionView, kind, indexPath) -> UICollectionReusableView? in
            
            if kind == UICollectionView.elementKindSectionHeader {
                
                guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: MyCustomHeader.identifier, for: indexPath) as? MyCustomHeader else {
                    return nil
                }
                header.configure(with: "Header Title")
                return header
                
            } else if kind == UICollectionView.elementKindSectionFooter {
                
                guard let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: MyCustomFooter.identifier, for: indexPath) as? MyCustomFooter else {
                    return nil
                }
                footer.configure(with: "Footer Label")
                return footer
                
            }
            return nil
        }
        
    }
    
    private func applyInitialSnapshots() {
        var snapshot = NSDiffableDataSourceSnapshot<Int, Item>()
        snapshot.appendSections([0])
        snapshot.appendItems([Item(), Item(), Item(), Item(), Item(), Item()], toSection: 0)
        dataSource.apply(snapshot, animatingDifferences: false)
    }
    
    func fetchDataFromServer(completion: @escaping ([Item]) -> Void) {
        // 模擬網路請求延遲
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            // 模擬新數據
            let newItems = (0..<20).map { _ in Item() }
            completion(newItems)
        }
    }
    
    private func updateSnapshot(with newItems: [Item]) {
        var snapshot = NSDiffableDataSourceSnapshot<Int, Item>()
        snapshot.appendSections([0])
        snapshot.appendItems(newItems, toSection: 0)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    

}

extension ViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("項目 \(indexPath.row) 被點擊")
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 50)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 50)
    }
}

struct Item: Hashable {
    let id = UUID()
}

