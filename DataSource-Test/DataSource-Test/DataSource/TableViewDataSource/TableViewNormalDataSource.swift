//
//  TableViewNormalDataSource.swift
//  DataSource-Swift
//
//  Created by jqy on 2020/11/24.
//

import UIKit

/*
  普通列表数据展示
  数据源为一维数组，数组内元素即为配置cell所需数据
 */

class TableViewNormalDataSource<RowModelClass>: NSObject,UITableViewDataSource,UITableViewDelegate {
    
    private var configureCell : ConfigureCellCallback<RowModelClass>
    private var dataArray     : [RowModelClass]?
    private var heightForRow  : HeightForRowCallback<RowModelClass>?
    private var didSelectRow  : DidSelectRowCallback<RowModelClass>?
    
    init(configureCell : @escaping ConfigureCellCallback<RowModelClass>){
        self.configureCell = configureCell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.dataArray?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        self.configureCell(tableView,self.modelOfRowIn(tableView,indexPath),indexPath)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.didSelectRow?(tableView,self.modelOfRowIn(tableView,indexPath),indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        heightForRow?(tableView,self.modelOfRowIn(tableView,indexPath),indexPath) ?? tableView.rowHeight
    }
    
    private func modelOfRowIn(_ tableView:UITableView,_ indexPath:IndexPath) -> RowModelClass? {
        self.dataArray?[indexPath.row]
    }
    
    func configureRowHeight(_ callback:@escaping HeightForRowCallback<RowModelClass>) {
        self.heightForRow = callback
    }
    
    func didSelectRow(_ callback:@escaping DidSelectRowCallback<RowModelClass>) {
        self.didSelectRow = callback
    }
    
    func addData(_ dataArray:[RowModelClass]) {
         self.dataArray = dataArray
    }
}
