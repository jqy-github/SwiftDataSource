//
//  TableViewSectionHeaderFooterDataSourceVC.swift
//  DataSource-Test
//
//  Created by jqy on 2020/11/25.
//

import UIKit

class TableViewSectionHeaderFooterVC: UIViewController {

    var dataSource : TableViewGroupedDataSource<String,SectionModel>?
    var tableView  : UITableView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView = UITableView.init(frame: .zero, style: .grouped)
        tableView?.rowHeight = 50
        tableView?.register(UITableViewCell.self, forCellReuseIdentifier: "cell_id")
        tableView?.register(UITableViewHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: "header_id")
        tableView?.register(UITableViewHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: "footer_id")
        self.view = tableView
        
        dataSource = TableViewGroupedDataSource<String,SectionModel>.init(modelStyle: .grouped2(nil, { (table, model, section) -> Int? in
            model?.contents?.count
        }, { (table, model, indexPath) -> String? in
            model?.contents?[indexPath.row]
        }), configureCell: { (table, model, indexPath) -> UITableViewCell in
            let cell = table.dequeueReusableCell(withIdentifier: "cell_id")!
            cell.textLabel?.text = model
            cell.textLabel?.font = UIFont.systemFont(ofSize: 15)
            return cell
        }, configureHeader: { (table, model, section) -> UIView? in
            let header = table.dequeueReusableHeaderFooterView(withIdentifier: "header_id")
            header?.textLabel?.text = model?.title
            header?.contentView.backgroundColor = .yellow
            return header
        }, configureFooter: { (table, model, section) -> UIView? in
            let footer = table.dequeueReusableHeaderFooterView(withIdentifier: "footer_id")
            footer?.textLabel?.text = model?.footer
            footer?.contentView.backgroundColor = .blue
            return footer
        })
        
        dataSource?.configureHeaderHeight({ (table, model, section) -> CGFloat in
            30
        })
        
        dataSource?.configureFooterHeight({ (table, model, section) -> CGFloat in
            30
        })
        
        tableView?.delegate = dataSource
        tableView?.dataSource = dataSource
        
        self.loadData()
        // Do any additional setup after loading the view.
    }
    

    func loadData() {
        var sarr = [SectionModel]()
        for i in 0..<6 {
            let model = SectionModel()
            model.title = "头-\(i)"
            model.footer = "尾-\(i)"
            var contents = [String]()
            for j in 0..<6 {
                contents.append("第\(i)组第\(j)单元")
            }
            model.contents = contents
            sarr.append(model)
        }
        dataSource?.addData(sarr)
    }

}
