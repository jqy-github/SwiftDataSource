//
//  TableViewGroupedDataSource.swift
//  DataSource-Swift
//
//  Created by JY on 2020/11/24.
//

import UIKit

/*
 可返回头部、尾部列表数据类型
 */

class TableViewGroupedDataSource<RowModelClass, SectionModelClass>: NSObject, UITableViewDataSource, UITableViewDelegate {
    private var configureCell: ConfigureCellCallback<RowModelClass>
    private var configureHeader: ConfigureTableViewHeaderFooterCallback<SectionModelClass>?
    private var configureFooter: ConfigureTableViewHeaderFooterCallback<SectionModelClass>?
    private var modelStyle: TableViewDataSourceModelStyle<RowModelClass, SectionModelClass>
    private var dataArray: [SectionModelClass]?
    private var heightForRow: HeightForRowCallback<RowModelClass>?
    private var heightForHeader: HeightForTableViewHeaderFooterCallback<SectionModelClass>?
    private var heightForFooter: HeightForTableViewHeaderFooterCallback<SectionModelClass>?
    private var didSelectRow: DidSelectRowCallback<RowModelClass>?

    init(modelStyle: TableViewDataSourceModelStyle<RowModelClass, SectionModelClass>,
         configureCell: @escaping ConfigureCellCallback<RowModelClass>,
         configureHeader: ConfigureTableViewHeaderFooterCallback<SectionModelClass>? = nil,
         configureFooter: ConfigureTableViewHeaderFooterCallback<SectionModelClass>? = nil) {
        self.configureCell = configureCell
        self.configureHeader = configureHeader
        self.configureFooter = configureFooter
        self.modelStyle = modelStyle
        switch modelStyle {
        case let .grouped1(data):
            dataArray = data as? [SectionModelClass]
        case let .grouped2(data, _, _):
            dataArray = data
        }
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        dataArray?.count ?? 0
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch modelStyle {
        case .grouped1:
            return (dataArray as? [[RowModelClass]])?[section].count ?? 0
        case let .grouped2(_, numberOfRows, _):
            return numberOfRows(tableView, modelOfSectionIn(section), section) ?? 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        configureCell(tableView, modelOfRowIn(tableView, indexPath), indexPath)
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        configureHeader?(tableView, modelOfSectionIn(section), section)
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        configureFooter?(tableView, modelOfSectionIn(section), section)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        heightForRow?(tableView, modelOfRowIn(tableView, indexPath), indexPath) ?? tableView.rowHeight
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        heightForHeader?(tableView, modelOfSectionIn(section), section) ?? tableView.sectionHeaderHeight
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        heightForFooter?(tableView, modelOfSectionIn(section), section) ?? tableView.sectionFooterHeight
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        didSelectRow?(tableView, modelOfRowIn(tableView, indexPath), indexPath)
    }

    private func modelOfRowIn(_ tableView: UITableView, _ indexPath: IndexPath) -> RowModelClass? {
        switch modelStyle {
        case .grouped1:
            return (dataArray as? [[RowModelClass]])?[indexPath.section][indexPath.row]
        case let .grouped2(_, _, modelForRow):
            return modelForRow(tableView, modelOfSectionIn(indexPath.section), indexPath)
        }
    }

    private func modelOfSectionIn(_ section: Int) -> SectionModelClass? {
        dataArray?[section]
    }

    func configureRowHeight(_ callback: @escaping HeightForRowCallback<RowModelClass>) {
        heightForRow = callback
    }

    func configureHeaderHeight(_ callback: @escaping HeightForTableViewHeaderFooterCallback<SectionModelClass>) {
        heightForHeader = callback
    }

    func configureFooterHeight(_ callback: @escaping HeightForTableViewHeaderFooterCallback<SectionModelClass>) {
        heightForFooter = callback
    }

    func didSelectRow(_ callback: @escaping DidSelectRowCallback<RowModelClass>) {
        didSelectRow = callback
    }

    func addData(_ dataArray: [SectionModelClass]) {
        self.dataArray = dataArray
    }
}
