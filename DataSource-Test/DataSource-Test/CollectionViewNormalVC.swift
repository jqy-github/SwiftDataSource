//
//  CollectionViewNormalVC.swift
//  DataSource-Test
//
//  Created by JY on 2020/11/25.
//

import UIKit

class CollectionViewNormalVC: UIViewController {

    var collectionView : UICollectionView?
    var dataSource : CollectionViewNormalDataSource<UIColor>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 1
        collectionView = UICollectionView.init(frame: .zero,collectionViewLayout: layout)
        collectionView?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell_id")
        collectionView?.backgroundColor = .white
        self.view = collectionView
        
        dataSource = CollectionViewNormalDataSource.init(configureItem: { (collection, model, indexPath) -> UICollectionViewCell in
            let cell = collection.dequeueReusableCell(withReuseIdentifier: "cell_id", for: indexPath)
            cell.backgroundColor = model
            return cell
        })
        dataSource?.configureItemSize({ (collection, collectionViewLayout, model, indexPath) -> CGSize in
            CGSize(width: (UIScreen.main.bounds.size.width/3) - 2, height: UIScreen.main.bounds.size.width/3)
        })
        
        dataSource?.didSelectItem({[weak self] (collection, model, indexPath) in
            let alert = UIAlertController.init(title: nil, message: "你点击了第\(indexPath.row+1)个", preferredStyle: .alert)
            let action = UIAlertAction.init(title: "确定", style: .cancel, handler: nil)
            alert.addAction(action)
            self?.present(alert, animated: true, completion: nil)
        })
        
        collectionView?.delegate = dataSource
        collectionView?.dataSource = dataSource
        dataSource?.addData(colors)
        // Do any additional setup after loading the view.
    }
    
    let colors : [UIColor] = {
        [.red,.orange,.yellow,.green,.cyan,.blue,.purple]
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
