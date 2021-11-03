//
//  TableViewNormalVC.swift
//  DataSource-Test
//
//  Created by JY on 2020/11/25.
//

import UIKit

class TableViewNormalVC: UIViewController {

    var dataSource : TableViewNormalDataSource<CellModel>?
    var tableView  : UITableView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        tableView = UITableView()
        self.view = tableView
        
        dataSource = TableViewNormalDataSource.init(configureCell: { (table, model, indexPath) -> UITableViewCell in
            var cell = table.dequeueReusableCell(withIdentifier: "cell_id")
            if cell == nil {
               cell = UITableViewCell.init(style: .subtitle, reuseIdentifier: "cell_id")
            }
            cell?.textLabel?.text = (model?.title ?? "") + "\(indexPath.row)"
            cell?.detailTextLabel?.text = (model?.subTitle ?? "") + "\(indexPath.row)"
            return cell!
        })
        dataSource?.configureRowHeight({ (table, model, indexPath) -> CGFloat in
            100
        })
        tableView?.dataSource = dataSource
        tableView?.delegate = dataSource
        
        self.loadData()
    }
    

    func loadData() {
        let resources = [["title"   : "我是标题",
                          "subTitle": "我是描述"],
                         ["title"   : "我是标题",
                          "subTitle": "我是描述"],
                         ["title"   : "我是标题",
                          "subTitle": "我是描述"],
                         ["title"   : "我是标题",
                          "subTitle": "我是描述"],
                         ["title"   : "我是标题",
                          "subTitle": "我是描述"],
                         ["title"   : "我是标题",
                          "subTitle": "我是描述"],
                         ["title"   : "我是标题",
                          "subTitle": "我是描述"],
                         ["title"   : "我是标题",
                          "subTitle": "我是描述"],
                         ["title"   : "我是标题",
                          "subTitle": "我是描述"],
                         ["title"   : "我是标题",
                          "subTitle": "我是描述"]]
        var dataArray = [CellModel]()
        for resource in resources {
            let model = CellModel()
            model.setValuesForKeys(resource)
            dataArray.append(model)
        }
        dataSource?.addData(dataArray)
        tableView?.reloadData()
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
