//
//  IntroVC+ViewFactory.swift
//  ecash
//
//  Created by phong070 on 11/19/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import UIKit

extension IntroVC {
    func initUI(){
        viewGradient.startColor = AppColors.WHITE_COLOR
        viewGradient.endColor = AppColors.WHITE_COLOR
        viewGradient.startLocation = 0.65
        btnSKip.setTitle(LanguageHelper.getTranslationByKey(LanguageKey.Skip)?.uppercased(), for: .normal)
        btnSKip.addTarget(self, action: #selector(actionNavigation), for: .touchUpInside)
        btnSKip.setTitleColor(AppColors.GRAY_LIGHT_TEXT, for: .normal)
        control.currentPage = 0
        control.currentPageIndicatorTintColor = AppColors.BLUE
        control.isEnabled = false
        control.pageIndicatorTintColor = AppColors.GRAY_LIGHT_TEXT
        setupCollectionView()
        bindViewModel()
    }
    
    func bindViewModel() {
        self.viewModel.showLoading.bind { visible in
            visible ? ProgressHUD.show(): ProgressHUD.dismiss()
        }
        self.viewModel.onShowError = { [weak self] alert in
            self?.presentSingleButtonDialog(alert: alert)
        }
        self.viewModel.responseToView = { [weak self] value in
            if value == EnumResponseToView.UPDATE_DATA_SOURCE.rawValue {
                self?.updateCollectionViewDataSource()
            }else if value == EnumResponseToView.SKIP.rawValue {
                self?.doSkip()
            }
            else if value == EnumResponseToView.START.rawValue{
                self?.doStart()
            }
        }
        self.bindCollectionView()
        self.viewModel.doIntro()
    }
    
    func updateCollectionViewDataSource() {
        self.collectionViewDataSource.items = self.viewModel.list
        self.control.numberOfPages = self.viewModel.list.count
        self.collectionViewDataSource.listener = self
        self.collectionViewDataSource.widthView = view.frame.width
        self.collectionViewDataSource.heightView = 300
        self.collectionViewDataSource.onScrolledAtCurrentPage = { value in
            self.control.currentPage = value
            self.viewModel.doPaging(index: value)
            debugPrint(value)
        }
        self.collectionView.reloadData()
        debugPrint("updateCollectionViewDataSource")
    }
    
    func bindCollectionView(){
        /*Setup collectionview*/
        self.collectionViewDataSource = CollectionViewDataSource(cellIdentifier: EnumIdentifier.Intro.rawValue,size: 100, items: self.viewModel.list){ cell , vm in
            cell.delegate = self
            cell.configView(view: vm)
        }
        self.collectionViewDataSource.listener = self
        self.collectionViewDataSource.widthView = view.frame.width
        self.collectionViewDataSource.heightView = 300
        self.collectionViewDataSource.onScrolledAtCurrentPage = { value in
            self.control.currentPage = value
            self.viewModel.doPaging(index: value)
            debugPrint(value)
        }
        self.collectionView.dataSource = self.collectionViewDataSource
        self.collectionView.delegate = self.collectionViewDataSource
    }
    
    func setupCollectionView(){
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: EnumIdentifier.Intro.rawValue)
    }
    
    func doSkip(){
        btnSKip.setTitle(LanguageHelper.getTranslationByKey(LanguageKey.Skip)?.uppercased(), for: .normal)
        btnSKip.setTitleColor(AppColors.GRAY_LIGHT_TEXT, for: .normal)
        btnSKip.cornerButton(corner: 3, color: .clear)
    }
    
    func doStart(){
        btnSKip.setTitle(LanguageHelper.getTranslationByKey(LanguageKey.Start)?.uppercased(), for: .normal)
        btnSKip.setTitleColor(.white, for: .normal)
        btnSKip.cornerButton(corner: 3, color: AppColors.BLUE)
    }
}

extension IntroVC : CollectionViewCellDelegate {
    func cellCodable(codable: Codable) {
    }
    func cellViewSelected(cell: CollectionViewCell) {
        guard let indexPath = collectionView.indexPath(for: cell) else { return }
        log(message: "Index \(indexPath.row)")
    }
}

extension IntroVC : SingleButtonDialogPresenter {
    
}

extension IntroVC : IntroCellDelegate {
    func onSkip() {
        
    }
    func onStart(isStart: Bool) {
    }
}
