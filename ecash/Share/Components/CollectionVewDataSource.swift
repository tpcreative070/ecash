//
//  CollectionVewDataSource.swift
//  vietlifetravel
//
//  Created by phong070 on 7/12/19.
//  Copyright © 2019 Mac10. All rights reserved.
//

import UIKit
class CollectionViewDataSource <Cell: UICollectionViewCell,ViewModel> : NSObject, UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    private var cellIdentifier :String!
    var items :[ViewModel]!
    var configureCell :((Cell,ViewModel) -> ())
    var loadMore:(() -> ())?
    var listener : IntroCellDelegate?
    var onScrolledAtCurrentPage: ((Int) -> Void)?
    var size : Int
    var widthView : CGFloat?
    var heightView : CGFloat?
    
  
    init(cellIdentifier :String,size : Int? = 0, items :[ViewModel], configureCell: @escaping (Cell,ViewModel) -> ()) {
        self.cellIdentifier = cellIdentifier
        self.items = items
        self.configureCell = configureCell
        self.size = size ?? 100
    }
  
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.cellIdentifier, for: indexPath) as! Cell
        let item = self.items[indexPath.row]
        self.configureCell(cell,item)
        if indexPath.row == self.items.count - 1 && self.items.count > 0  {
            self.loadMore?()
        }
        if let mListener = listener{
            mListener.onStart(isStart: indexPath.row == self.items.count - 1)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if let mWidth = widthView, let mHeight = heightView {
            return CGSize(width: mWidth , height: mHeight)
        }else{
            return CGSize(width: size , height: size)
        }
     
    }
        
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return .zero
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        guard let mWidth = widthView else {
            return
        }
        let pageNumber: Int = Int(targetContentOffset.pointee.x / mWidth)
           onScrolledAtCurrentPage!(pageNumber)
    }

}

