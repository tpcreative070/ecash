//
//  TableSection.swift
//  vietlifetravel
//
//  Created by Mac10 on 7/5/19.
//  Copyright © 2019 Mac10. All rights reserved.
//

import Foundation
struct TableSection<SectionItem : Comparable&Hashable, RowItem> : Comparable {
    var sectionItem : SectionItem
    var rowItems : [RowItem]
    static func < (lhs: TableSection, rhs: TableSection) -> Bool {
        return lhs.sectionItem < rhs.sectionItem
    }
    
    static func == (lhs: TableSection, rhs: TableSection) -> Bool {
        return lhs.sectionItem == rhs.sectionItem
    }
    
    static func group(rowItems : [RowItem], by criteria : (RowItem) -> SectionItem ) -> [TableSection<SectionItem, RowItem>] {
        let groups = Dictionary(grouping: rowItems, by: criteria)
        return groups.map(TableSection.init(sectionItem:rowItems:)).sorted().reversed()
    }
}
