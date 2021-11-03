//
//  TableViewDataSourceTypealias.swift
//  DataSource-Swift
//
//  Created by JY on 2020/11/24.
//

import UIKit

/*
 RowModelClass : 单元(配置cell所需数据)据类型
 SectionModelClass : 组(配置header/footer所需数据)数据类型
 */

typealias ConfigureCellCallback<RowModelClass>                      = (_ tableView: UITableView,_ model:RowModelClass?,_ indexPath:IndexPath) -> UITableViewCell
typealias ConfigureTableViewHeaderFooterCallback<SectionModelClass> = (_ tableView: UITableView,_ model:SectionModelClass?,_ section:Int) -> UIView?
typealias NumberOfRowsCallback<SectionModelClass>                   = (_ tableView: UITableView,_ model:SectionModelClass?,_ section:Int) -> Int?
typealias ModelForRowCallback<SectionModelClass,RowModelClass>      = (_ tableView: UITableView,_ model:SectionModelClass?,_ indexPath:IndexPath) -> RowModelClass?
typealias DidSelectRowCallback<RowModelClass>                       = (_ tableView: UITableView,_ model:RowModelClass?,_ indexPath:IndexPath) -> Void
typealias HeightForRowCallback<RowModelClass>                       = (_ tableView: UITableView,_ model:RowModelClass?,_ indexPath:IndexPath) -> CGFloat
typealias HeightForTableViewHeaderFooterCallback<SectionModelClass> = (_ tableView: UITableView,_ model:SectionModelClass?,_ section:Int) -> CGFloat


