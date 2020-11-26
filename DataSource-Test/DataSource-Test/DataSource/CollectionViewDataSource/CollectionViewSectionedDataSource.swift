//
//  CollectionViewSectionedDataSource.swift
//  DataSource-Swift
//
//  Created by jqy on 2020/11/24.
//

import UIKit

/*
 可返回头部、尾部列表数据类型
 */

class CollectionViewSectionedDataSource<ItemModelClass,SectionModelClass>: NSObject,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    
    private var configureItem         : ConfigureItemCallback<ItemModelClass>
    private var configureHeaderFooter : ConfigureCollectionViewHeaderFooterCallback<SectionModelClass>
    private var modelStyle            : CollectionViewDataSourceModelStyle<ItemModelClass,SectionModelClass>
    private var dataArray             : [SectionModelClass]?
    private var sizeForItem           : SizeForItemCallback<ItemModelClass>?
    private var sizeForHeader         : SizeForCollectionViewHeaderFooterCallback<SectionModelClass>?
    private var sizeForFooter         : SizeForCollectionViewHeaderFooterCallback<SectionModelClass>?
    private var didSelectItem         : DidSelectItemCallback<ItemModelClass>?
    
    init(modelStyle            : CollectionViewDataSourceModelStyle<ItemModelClass,SectionModelClass>,
         configureItem         : @escaping ConfigureItemCallback<ItemModelClass>,
         configureHeaderFooter : @escaping ConfigureCollectionViewHeaderFooterCallback<SectionModelClass>){
         self.configureItem         = configureItem
         self.configureHeaderFooter = configureHeaderFooter
         self.modelStyle            = modelStyle
         switch modelStyle {
         case .grouped1(let data):
            self.dataArray = data as? [SectionModelClass]
         case .grouped2(let data, _, _):
            self.dataArray = data
         }
    }

    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        self.dataArray?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch modelStyle {
        case .grouped1(_):
            return (self.dataArray as? [[ItemModelClass]])?[section].count ?? 0
        case .grouped2(_,let numberOfItems,_):
            return numberOfItems(collectionView,self.modelOfSectionIn(section),section) ?? 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        self.configureHeaderFooter(collectionView,self.modelOfSectionIn(indexPath.section),kind,indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        self.configureItem(collectionView,self.modelOfItemIn(collectionView, indexPath),indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        sizeForItem?(collectionView,collectionViewLayout,self.modelOfItemIn(collectionView, indexPath),indexPath) ?? (collectionViewLayout as? UICollectionViewFlowLayout)?.itemSize ?? .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        sizeForHeader?(collectionView,collectionViewLayout,self.modelOfSectionIn(section),section) ?? (collectionViewLayout as? UICollectionViewFlowLayout)?.headerReferenceSize ?? .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        sizeForFooter?(collectionView,collectionViewLayout,self.modelOfSectionIn(section),section) ?? (collectionViewLayout as? UICollectionViewFlowLayout)?.footerReferenceSize ?? .zero
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.didSelectItem?(collectionView,self.modelOfItemIn(collectionView,indexPath),indexPath)
    }
    
    private func modelOfItemIn(_ collectionView:UICollectionView,_ indexPath:IndexPath) -> ItemModelClass? {
        switch modelStyle {
        case .grouped1(_):
            return (self.dataArray as? [[ItemModelClass]])?[indexPath.section][indexPath.row]
        case .grouped2(_,_,let modelForRow):
            return modelForRow(collectionView,self.modelOfSectionIn(indexPath.section),indexPath)
        }
    }
    
    private func modelOfSectionIn(_ section: Int) -> SectionModelClass? {
        return self.dataArray?[section]
    }
    
    func configureItemSize(_ callback:@escaping SizeForItemCallback<ItemModelClass>) {
        self.sizeForItem = callback
    }
    
    func configureHeaderSize(_ callback:@escaping SizeForCollectionViewHeaderFooterCallback<SectionModelClass>) {
        self.sizeForHeader = callback
    }
    
    func configureFooterSize(_ callback:@escaping SizeForCollectionViewHeaderFooterCallback<SectionModelClass>) {
        self.sizeForFooter = callback
    }
    
    func didSelectItem(_ callback:@escaping DidSelectItemCallback<ItemModelClass>) {
        self.didSelectItem = callback
    }
    
    func addData(_ dataArray:[SectionModelClass]) {
         self.dataArray = dataArray
    }
}
