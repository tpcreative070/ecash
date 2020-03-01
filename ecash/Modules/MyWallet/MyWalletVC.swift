//
//  MyWalletVC.swift
//  ecash
//
//  Created by phong070 on 8/27/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import UIKit
class MyWalletVC : SwipeMenuViewController {
    @IBOutlet weak var imgLogo : UIImageView!
    @IBOutlet weak var imgScanner : UIImageView!
    var options = SwipeMenuViewOptions()
    var myWallet : TabWalletVC?
    var myProfile : TabProfileVC?
    var dataCount: Int = 2
    let mainStoryBoard : UIStoryboard = UIStoryboard(name: Storyboard.settings, bundle: nil)

    override func viewDidLoad() {
        addedView()
        super.viewDidLoad()
        initUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        checkSessionExpired()
    }
    // MARK: - SwipeMenuViewDelegate
    override func swipeMenuView(_ swipeMenuView: SwipeMenuView, viewWillSetupAt currentIndex: Int) {
        super.swipeMenuView(swipeMenuView, viewWillSetupAt: currentIndex)
        print("will setup SwipeMenuView")
    }
    
    override func swipeMenuView(_ swipeMenuView: SwipeMenuView, viewDidSetupAt currentIndex: Int) {
        super.swipeMenuView(swipeMenuView, viewDidSetupAt: currentIndex)
        print("did setup SwipeMenuView")
    }
    
    override func swipeMenuView(_ swipeMenuView: SwipeMenuView, willChangeIndexFrom fromIndex: Int, to toIndex: Int) {
        super.swipeMenuView(swipeMenuView, willChangeIndexFrom: fromIndex, to: toIndex)
        print("will change from section\(fromIndex + 1)  to section\(toIndex + 1)")
    }
    
    override func swipeMenuView(_ swipeMenuView: SwipeMenuView, didChangeIndexFrom fromIndex: Int, to toIndex: Int) {
        super.swipeMenuView(swipeMenuView, didChangeIndexFrom: fromIndex, to: toIndex)
        print("did change from section\(fromIndex + 1)  to section\(toIndex + 1)")
    }
    
    // MARK - SwipeMenuViewDataSource
    override func numberOfPages(in swipeMenuView: SwipeMenuView) -> Int {
        return dataCount
    }
    
    override func swipeMenuView(_ swipeMenuView: SwipeMenuView, titleForPageAt index: Int) -> String {
        return children[index].title ?? ""
    }
    
    override func swipeMenuView(_ swipeMenuView: SwipeMenuView, viewControllerForPageAt index: Int) -> UIViewController {
        let vc = children[index]
        vc.didMove(toParent: self)
        return vc
    }
    
    @objc func actionScanner(sender : UITapGestureRecognizer){
        debugPrint("Action here....")
        if !CommonService.isActiveAccount() {
            self.onAlertMessage(value: LanguageHelper.getTranslationByKey(LanguageKey.PleaseActiveAccountToUseThisFeature) ?? "")
            return
        }
        tabBarController?.selectedIndex = 2
    }
}
