//
//  TableViewSectionFooterVC.swift
//  DataSource-Test
//
//  Created by jqy on 2020/11/25.
//

import UIKit

class TableViewSectionFooterVC: UIViewController {

    var dataSource : TableViewGroupedDataSource<String,[String]>?
    var tableView  : UITableView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView = UITableView.init(frame: .zero, style: .grouped)
        tableView?.rowHeight = 50
        tableView?.sectionFooterHeight = 60
        tableView?.sectionHeaderHeight = 0
        tableView?.tableHeaderView = UIView.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 0.1))
        tableView?.register(UITableViewCell.self, forCellReuseIdentifier: "cell_id")
        tableView?.register(UITableViewHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: "footer_id")
        self.view = tableView
        
        dataSource = TableViewGroupedDataSource.init(modelStyle: .grouped1(nil), configureCell: { (table, model, indexPath) -> UITableViewCell in
            let cell = table.dequeueReusableCell(withIdentifier: "cell_id")!
            cell.textLabel?.text = model
            return cell
        }, configureFooter: { (table, model, section) -> UIView? in
            let footer = table.dequeueReusableHeaderFooterView(withIdentifier: "footer_id")
            footer?.textLabel?.text = "我是尾部"
            return footer
        })
        tableView?.dataSource = dataSource
        tableView?.delegate = dataSource
        self.loadData()
    }
    
    func loadData() {
        var sarr = [[String]]()
        for i in 0..<6 {
            var marr = [String]()
            for j in 0..<6 {
                marr.append("第\(i)组第\(j)单元")
            }
            sarr.append(marr)
        }
        dataSource?.addData(sarr)
    }

}
