//
//  IntroVC.swift
//  ecash
//
//  Created by phong070 on 11/19/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import UIKit
class IntroVC : BaseViewController {
    @IBOutlet weak var btnSKip : ICButton!
    @IBOutlet weak var control : UIPageControl!
    @IBOutlet weak var collectionView : UICollectionView!
    @IBOutlet weak var viewGradient : ICGradientView!
    var collectionViewDataSource :CollectionViewDataSource<CollectionViewCell,IntroViewModel>!
    let viewModel = IntroViewModelList()
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
    }
    
    @IBOutlet weak var viewCollection: UIView!
    override func viewWillAppear(_ animated: Bool) {
        CollectionViewCell.identifier = EnumIdentifier.Intro
    }
    
    @objc func actionNavigation(){
        CommonService.setIsIntro(data: true)
        CommonService.initTab()
    }
}
