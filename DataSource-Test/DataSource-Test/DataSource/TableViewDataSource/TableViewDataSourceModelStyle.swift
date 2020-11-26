//
//  TableViewDataSourceModelStyle.swift
//  DataSource-Swift
//
//  Created by jqy on 2020/11/24.
//

/*
 RowModelClass : 单元(配置cell所需数据)据类型
 SectionModelClass : 组(配置header/footer所需数据)数据类型
 grouped1 : 二维数组数据类型(一般配置cell所需数据类型为底层数组内的元素)
 grouped2 : 一维数组数据类型(一般配置cell所需数据类型为数组元素内某个数组属性内的元素)
 */

enum TableViewDataSourceModelStyle<RowModelClass,SectionModelClass> {
    case grouped1([[RowModelClass]]?)
    case grouped2([SectionModelClass]?,
                  NumberOfRowsCallback<SectionModelClass>,
                  ModelForRowCallback<SectionModelClass,RowModelClass>)
}
