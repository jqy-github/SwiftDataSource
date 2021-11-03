//
//  CollectionViewNormalDataSource.swift
//  DataSource-Swift
//
//  Created by JY on 2020/11/24.
//

import UIKit

/*
  普通列表数据展示
  数据源为一维数组，数组内元素即为配置cell所需数据
 */

class CollectionViewNormalDataSource<ItemModelClass>: NSObject,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    
    private var configureItem : ConfigureItemCallback<ItemModelClass>
    private var dataArray     : [ItemModelClass]?
    private var sizeForItem   : SizeForItemCallback<ItemModelClass>?
    private var didSelectItem : DidSelectItemCallback<ItemModelClass>?
    
    init(configureItem : @escaping ConfigureItemCallback<ItemModelClass>){
        self.configureItem = configureItem
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.dataArray?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        self.configureItem(collectionView,self.modelOfItemIn(collectionView, indexPath),indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.didSelectItem?(collectionView,self.modelOfItemIn(collectionView,indexPath),indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
       sizeForItem?(collectionView,collectionViewLayout,self.modelOfItemIn(collectionView, indexPath),indexPath) ?? (collectionViewLayout as? UICollectionViewFlowLayout)?.itemSize ?? .zero
    }
    
    private func modelOfItemIn(_ collectionView:UICollectionView,_ indexPath:IndexPath) -> ItemModelClass? {
        self.dataArray?[indexPath.row]
    }
    
    func configureItemSize(_ callback:@escaping SizeForItemCallback<ItemModelClass>) {
        self.sizeForItem = callback
    }
    
    func didSelectItem(_ callback:@escaping DidSelectItemCallback<ItemModelClass>) {
        self.didSelectItem = callback
    }
    
    func addData(_ dataArray:[ItemModelClass]) {
         self.dataArray = dataArray
    }
}
