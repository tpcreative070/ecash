//
//  ProgressHUD.swift
//  vietlifetravel
//
//  Created by Mac10 on 6/26/19.
//  Copyright © 2019 Mac10. All rights reserved.
//

import UIKit
class  ProgressHUD: UIView {
    private var backgroundView: UIView = {
        let view = UIView.init(frame: UIScreen.main.bounds)
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        view.alpha = 0
        return view
    }()
    private var borderView: UIView = {
        let view = UIView.init(frame: CGRect(x: 0, y: 0, width: 80, height: 80))
        view.layer.cornerRadius = 5
        view.alpha = 0
        view.clipsToBounds = true
        view.backgroundColor = .gray
        view.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        return view
    }()
    private var indefiniteAnimatedView: IndefiniteAnimatedView = {
        let indefiniteAnimatedView = IndefiniteAnimatedView.init(frame: .zero)
        indefiniteAnimatedView.alpha = 0
        indefiniteAnimatedView.setIndefinite(strokeColor: .white)
        indefiniteAnimatedView.setIndefinite(strokeThickness: 3)
        indefiniteAnimatedView.setIndefinite(radius: 20)
        indefiniteAnimatedView.sizeToFit()
        return indefiniteAnimatedView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setUpView(){
        self.addSubview(backgroundView)
        self.addSubview(borderView)
        borderView.center = self.center
        borderView.addSubview(indefiniteAnimatedView)
        indefiniteAnimatedView.center = CGPoint(x: borderView.bounds.width/2, y: borderView.bounds.height/2)
    }
    
    private static let sharedView : ProgressHUD = {
        var localInstance : ProgressHUD?
        localInstance = ProgressHUD.init(frame: UIScreen.main.bounds)
        return localInstance!
    }()
    
    public class func show() {
        showInView(view: sharedView.getFrontWindow())
    }
    
    public class func showInView(view: UIView?){
        if sharedView.backgroundView.alpha != 0 {
            return
        }
        view?.addSubview(sharedView)
        UIView.animate(withDuration: 0.2, delay: 0, options: [.allowUserInteraction, .curveEaseOut], animations: {
            sharedView.borderView.alpha = 1
            sharedView.indefiniteAnimatedView.alpha = 1
            sharedView.borderView.alpha = 1
            sharedView.backgroundView.alpha = 1
        }, completion: nil)
    }
    
    public class func dismiss() {
        UIView.animate(withDuration: 0.2, delay: 0, options: [.allowUserInteraction, .curveEaseOut], animations: {
            sharedView.indefiniteAnimatedView.alpha = 0
            sharedView.borderView.alpha = 0
            sharedView.backgroundView.alpha = 0
        }) { _ in
            sharedView.removeFromSuperview()
        }
    }
    
    private func getFrontWindow() -> UIWindow? {
        let frontToBackWindows: NSEnumerator = (UIApplication.shared.windows as NSArray).reverseObjectEnumerator()
        for window in frontToBackWindows {
            guard let win : UIWindow = window as? UIWindow else {return nil}
            let windowOnMainScreen: Bool = win.screen == UIScreen.main
            let windowIsVisible: Bool = !win.isHidden && (win.alpha > 0)
            var windowLevelSupported = false
            windowLevelSupported = win.windowLevel >= UIWindow.Level.normal && win.windowLevel <= UIWindow.Level.normal
            let windowKeyWindow = win.isKeyWindow
            if windowOnMainScreen && windowIsVisible && windowLevelSupported && windowKeyWindow {
                return win
            }
        }
        return nil
    }
}
