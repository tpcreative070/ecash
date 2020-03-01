//
//  TableViewDataSource.swift
//  vietlifetravel
//
//  Created by Mac10 on 6/26/19.
//  Copyright © 2019 Mac10. All rights reserved.
//

import UIKit
class TableViewDataSource<Cell: UITableViewCell,ViewModel, HeaderInSection : UITableViewHeaderFooterView> : NSObject, UITableViewDataSource, UITableViewDelegate {
    private var cellIdentifier :String!
    var items :[ViewModel]!
    var configureCell :((Cell,ViewModel) -> ())
    var configureSwipeCell :((Cell,ViewModel) -> ())?
    var headerSection :((HeaderInSection,ViewModel) -> ())?
    var loadMore:(() -> ())?
    var sections : [TableSection<String, ViewModel>]?
    var height : CGFloat?
    var isSelectionStype : Bool?
    var swipeActionRight : UISwipeActionsConfiguration?
    var swipeActionLeft : UISwipeActionsConfiguration?
    
    init(cellIdentifier :String, items :[ViewModel], isSelectionStype : Bool? = true, configureCell: @escaping (Cell,ViewModel) -> ()) {
        self.cellIdentifier = cellIdentifier
        self.items = items
        self.configureCell = configureCell
        self.isSelectionStype  = isSelectionStype
    }
    
    init(cellIdentifier :String, items :[ViewModel],sections : [TableSection<String,ViewModel>]? = nil, height : CGFloat? = nil,isSelectionStype : Bool? = true, configureCell: @escaping (Cell,ViewModel) -> ()) {
        self.cellIdentifier = cellIdentifier
        self.items = items
        self.sections = sections
        self.height = height
        self.configureCell = configureCell
        self.isSelectionStype = isSelectionStype
    }
   
    func numberOfSections(in tableView: UITableView) -> Int {
        if let data = self.sections{
            return data.count
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: self.cellIdentifier) as! HeaderInSection
        if let data = sections{
            let mSection = data[section]
            if mSection.rowItems.count>0 {
                self.headerSection!(headerView,mSection.rowItems[0])
            }
            return headerView
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return height ?? 0
    }
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let data = sections{
            let section = data[section]
            return section.rowItems.count
        }
        return self.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier, for: indexPath) as! Cell
        if let mSections = sections {
            let section = mSections[indexPath.section]
            let headline = section.rowItems[indexPath.row]
            self.configureCell(cell,headline)
            if indexPath.section == mSections.count - 1 && section.rowItems.count > 0  {
                if indexPath.row == section.rowItems.count - 1 {
                    self.loadMore?()
                }
            }
        }else{
            let item = self.items[indexPath.row]
            self.configureCell(cell,item)
            if indexPath.row == self.items.count - 1 && self.items.count > 0  {
                self.loadMore?()
            }
        }
        if !(isSelectionStype ?? false) {
            cell.selectionStyle = .none
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        guard let mConfigureSwipeCell = configureSwipeCell else {
            return UISwipeActionsConfiguration.init()
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier, for: indexPath) as! Cell
        if let mSections = sections {
            let section = mSections[indexPath.section]
            let headline = section.rowItems[indexPath.row]
            mConfigureSwipeCell(cell,headline)
        }else{
            let item = self.items[indexPath.row]
            mConfigureSwipeCell(cell,item)
        }
        if let mValue = swipeActionRight {
            return mValue
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        guard let mConfigureSwipeCell = configureSwipeCell else {
            return UISwipeActionsConfiguration.init()
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier, for: indexPath) as! Cell
        if let mSections = sections {
            let section = mSections[indexPath.section]
            let headline = section.rowItems[indexPath.row]
            mConfigureSwipeCell(cell,headline)
        }else{
            let item = self.items[indexPath.row]
            mConfigureSwipeCell(cell,item)
        }
        if let mValue = swipeActionLeft {
            return mValue
        }
        return nil
    }
    
}
