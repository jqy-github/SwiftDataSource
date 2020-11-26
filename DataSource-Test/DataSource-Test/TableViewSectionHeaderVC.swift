//
//  TableViewSectionHeaderVC.swift
//  DataSource-Test
//
//  Created by jqy on 2020/11/25.
//

import UIKit




class TableViewSectionHeaderVC: UIViewController {

    var dataSourceGrouped1 : TableViewSectionHeaderDataSource<String,[String]>?
    var dataSourceGrouped2 : TableViewSectionHeaderDataSource<String,SectionModel>?
    var tableView : UITableView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "TableViewSectionHeaderVC"
        
        tableView = UITableView()
        tableView?.rowHeight = 50
        tableView?.sectionHeaderHeight = 60
        tableView?.register(UITableViewCell.self, forCellReuseIdentifier: "cell_id")
        tableView?.register(UITableViewHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: "header_id")
        self.view = tableView
        
       // self.initDataSourceGrouped1()
          self.initDataSourceGrouped2()
        
    }
    
    func initDataSourceGrouped1() {
        
        dataSourceGrouped1 = TableViewSectionHeaderDataSource.init(modelStyle: .grouped1(grouped1Data), configureCell: { (table, model, indexPath) -> UITableViewCell in
            let cell = table.dequeueReusableCell(withIdentifier: "cell_id")!
            cell.accessoryType = .disclosureIndicator
            cell.textLabel?.text = model
            cell.textLabel?.font = UIFont.systemFont(ofSize: 15)
            return cell
        }, configureHeader: { (table, model, section) -> UIView? in
            let header = table.dequeueReusableHeaderFooterView(withIdentifier: "header_id")
            header?.textLabel?.text = "我是头部"
            return header
        })
        
        dataSourceGrouped1?.didSelectRow({[weak self] (table, model, indexPath) in
            let className = "DataSource_Test"+"."+model!
            let vc = (NSClassFromString(className) as! UIViewController.Type).init()
            self?.navigationController?.pushViewController(vc, animated: true)
        })

        tableView?.dataSource = dataSourceGrouped1
        tableView?.delegate = dataSourceGrouped1
    }
    
    func initDataSourceGrouped2() {
        
        dataSourceGrouped2 = TableViewSectionHeaderDataSource<String,SectionModel>.init(modelStyle: .grouped2(nil, { (table, model, section) -> Int? in
            //返回行数
            model?.contents?.count
        }, { (table, model, indexPath) -> String? in
            //返回配置cell所需数据
            model?.contents?[indexPath.row]
        }), configureCell: { (table, model, indexPath) -> UITableViewCell in
            //配置cell
            let cell = table.dequeueReusableCell(withIdentifier: "cell_id")!
            cell.accessoryType = .disclosureIndicator
            cell.textLabel?.text = model
            cell.textLabel?.font = UIFont.systemFont(ofSize: 15)
            return cell
        }, configureHeader: { (table, model, section) -> UIView? in
            //配置header
            let header = table.dequeueReusableHeaderFooterView(withIdentifier: "header_id")
            header?.textLabel?.text = model?.title
            return header
        })
        dataSourceGrouped2?.didSelectRow({[weak self] (table, model, indexPath) in
            let className = "DataSource_Test"+"."+model!
            let vc = (NSClassFromString(className) as! UIViewController.Type).init()
            self?.navigationController?.pushViewController(vc, animated: true)
        })
       
        tableView?.dataSource = dataSourceGrouped2
        tableView?.delegate = dataSourceGrouped2
        self.loadGrouped2Data()
    }
    
    lazy var grouped1Data = {
        [["TableViewNormalDataSourceVC",
          "TableViewSectionFooterDataSourceVC",
          "TableViewSectionHeaderFooterDataSourceVC"],
         ["CollectionViewNormalDataSourceVC",
          "CollectionViewSectionedDataSourceVC"]]
    }()
    
    func loadGrouped2Data() {
        let resources = [["title"   :"UITableViewDataSource",
                          "contents":["TableViewNormalDataSourceVC",
                                     "TableViewSectionFooterDataSourceVC",
                                     "TableViewSectionHeaderFooterDataSourceVC"]],
                         ["title"   :"UICollectionViewDataSource",
                          "contents":["CollectionViewNormalDataSourceVC",
                                     "CollectionViewSectionedDataSourceVC"]]]
        var dataArray = [SectionModel]()
        for resource in resources {
            let model = SectionModel()
            model.setValuesForKeys(resource)
            dataArray.append(model)
        }
        
        dataSourceGrouped2?.addData(dataArray)
        tableView?.reloadData()
    }
    
}

