//
//  CollectionViewSectionedDataSourceVC.swift
//  DataSource-Test
//
//  Created by jqy on 2020/11/25.
//

import UIKit

class CollectionViewSectionedDataSourceVC: UIViewController {

    var collectionView : UICollectionView?
    var dataSource : CollectionViewSectionedDataSource<UIColor,[UIColor]>?
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "CollectionViewSectionedDataSourceVC"
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: (UIScreen.main.bounds.size.width/3) - 2, height: UIScreen.main.bounds.size.width/3)
        layout.headerReferenceSize = CGSize(width: UIScreen.main.bounds.size.width, height: 50)
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 1
        collectionView = UICollectionView.init(frame: .zero,collectionViewLayout: layout)
        collectionView?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell_id")
        collectionView?.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header_id")
        collectionView?.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "footer_id")
        collectionView?.backgroundColor = .white
        self.view = collectionView
        
        dataSource = CollectionViewSectionedDataSource<UIColor,[UIColor]>.init(modelStyle: .grouped1(colors), configureItem: { (collection, model, indexPath) -> UICollectionViewCell in
            let cell = collection.dequeueReusableCell(withReuseIdentifier: "cell_id", for: indexPath)
            cell.backgroundColor = model
            return cell
        }, configureHeaderFooter: { (collection, mdoel, kind, indexPath) -> UICollectionReusableView in
            
            if kind == UICollectionView.elementKindSectionHeader {
                let header = collection.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "header_id", for: indexPath)
                header.subviews.forEach{ $0.removeFromSuperview(); }
                header.backgroundColor = .magenta
                let label = UILabel.init(frame: header.bounds)
                label.text = "-------- 头部 ---------"
                label.textAlignment = .center
                header.addSubview(label)
                return header
            }
            
            let footer = collection.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "footer_id", for: indexPath)
            footer.subviews.forEach{ $0.removeFromSuperview(); }
            footer.backgroundColor = .gray
            let label = UILabel.init(frame: footer.bounds)
            label.text = "-------- 尾部 ---------"
            label.textAlignment = .center
            footer.addSubview(label)
            return footer
        })
        
        dataSource?.configureFooterSize({ (collection, layout, model, section) -> CGSize in
            CGSize(width: UIScreen.main.bounds.size.width, height: 30)
        })
        
        collectionView?.delegate = dataSource
        collectionView?.dataSource = dataSource
    }
    
    let colors : [[UIColor]] = {
        [[.red,.orange,.yellow,.green,.cyan,.blue,.purple],
         [.red,.orange,.yellow,.green,.cyan,.blue,.purple],
         [.red,.orange,.yellow,.green,.cyan,.blue,.purple],
         [.red,.orange,.yellow,.green,.cyan,.blue,.purple],
         [.red,.orange,.yellow,.green,.cyan,.blue,.purple],
         [.red,.orange,.yellow,.green,.cyan,.blue,.purple]]
    }()

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
