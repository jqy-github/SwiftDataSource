//
//  CollectionViewDataSourceTypealias.swift
//  DataSource-Swift
//
//  Created by jqy on 2020/11/24.
//

import UIKit

/*
 ItemModelClass : 单元(配置cell所需数据)据类型
 SectionModelClass : 组(配置header/footer所需数据)数据类型
 */

typealias ConfigureItemCallback<ItemModelClass>                          = (_ collectionView: UICollectionView,_ model:ItemModelClass?,_ indexPath:IndexPath) -> UICollectionViewCell
typealias ConfigureCollectionViewHeaderFooterCallback<SectionModelClass> = (_ collectionView: UICollectionView,_ model:SectionModelClass?,_ kind:String, _ indexPath:IndexPath) -> UICollectionReusableView
typealias NumberOfItemsCallback<SectionModelClass>                       = (_ collectionView: UICollectionView,_ model:SectionModelClass?,_ section:Int) -> Int?
typealias ModelForItemCallback<SectionModelClass,ItemModelClass>         = (_ collectionView: UICollectionView,_ model:SectionModelClass?,_ indexPath:IndexPath) -> ItemModelClass?
typealias DidSelectItemCallback<ItemModelClass>                          = (_ collectionView: UICollectionView,_ model:ItemModelClass?,_ indexPath:IndexPath)->Void
typealias SizeForItemCallback<ItemModelClass>                            = (_ collectionView: UICollectionView,_ layout: UICollectionViewLayout,_ model:ItemModelClass?,_ indexPath:IndexPath)->CGSize
typealias SizeForCollectionViewHeaderFooterCallback<SectionModelClass>   = (_ collectionView: UICollectionView,_ layout: UICollectionViewLayout,_ model:SectionModelClass?,_ section:Int)->CGSize
