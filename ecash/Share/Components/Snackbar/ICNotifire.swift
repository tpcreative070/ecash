//
//  ICNotifire.swift
//  vietlifetravel
//
//  Created by phong070 on 7/17/19.
//  Copyright © 2019 Mac10. All rights reserved.
//

import UIKit
public class ICNotifire {
    public static let shared = ICNotifire()
    public let title = UILabel()
    public let color = UIColor.white
    private var notifireView: UIView = UIView()
    private var timer = 3
    private var timerNotifire: Timer?
    private var height = 10
    private let overLap = 55
    private var navBar: UINavigationController?
    private var isNavBar = false
    private var hNav = -15
    private var isShow = false
    private var topViewController: UIViewController?
    private init() {}
    private var completion: (() -> ())?
    var tap: UISwipeGestureRecognizer!
    var line = UIView()
    
    public func show(type: NotifireType, message: String, timer: Int = 3, completion: (() -> ())? = nil) {
        if !isShow {
            topViewController = UIApplication.shared.topMostViewController()
            hNav =  Int((topViewController?.view.safeAreaInsets.top) ?? 0)
            isShow = true
            self.timer = timer
            title.numberOfLines = 3
            title.text = message
            setupView(type: type)
            self.completion = completion
            animated()
            tap = UISwipeGestureRecognizer(target: self, action: #selector(dismiss))
            tap.direction = .up
            notifireView.addGestureRecognizer(tap)
        }
    }
    
    private func setupView(type: NotifireType) {
        let frameTopVC = topViewController?.view.frame
        let frame = CGRect(x: 0, y: -1000, width: Int((frameTopVC?.width)!), height: height)
        notifireView.frame = frame
        notifireView.backgroundColor = getColor(type: type)
        notifireView.layer.cornerRadius = 10.0
        notifireView.layer.shadowOpacity = 0.3
        notifireView.layer.shadowOffset = CGSize(width: 3, height: 3)
        topViewController?.view.addSubview(notifireView)
        notifireView.addSubview(title)
        title.translatesAutoresizingMaskIntoConstraints = false
        title.bottomAnchor.constraint(equalTo: (notifireView.bottomAnchor), constant: -16).isActive = true
        title.leftAnchor.constraint(equalTo: (notifireView.leftAnchor), constant: 16).isActive = true
        title.rightAnchor.constraint(equalTo: (notifireView.rightAnchor), constant: -16).isActive = true
        title.textColor = color
        notifireView.layoutSubviews()
        height = Int(title.frame.height + 100)
        notifireView.frame.size.height = CGFloat(height)
        
        line.backgroundColor = UIColor.white.withAlphaComponent(0.2)
        line.layer.cornerRadius = 2
        notifireView.addSubview(line)
        line.translatesAutoresizingMaskIntoConstraints = false
        line.bottomAnchor.constraint(equalTo: notifireView.bottomAnchor, constant: -3).isActive = true
        line.widthAnchor.constraint(equalToConstant: 100).isActive = true
        line.heightAnchor.constraint(equalToConstant: 4).isActive = true
        line.centerXAnchor.constraint(equalTo: notifireView.centerXAnchor).isActive = true
    }
    
    private func getColor(type: NotifireType) -> UIColor {
        switch type {
        case .info: return UIColor(red: 9/255, green: 194/255, blue: 102/255, alpha: 1.0)
        case .error: return UIColor(red: 1, green: 50/255, blue: 90/255, alpha: 1.0)
        case .warning: return UIColor(red: 254/255, green: 205/255, blue: 5/255, alpha: 1.0)
        }
    }
    
    private func animated(sender: UITapGestureRecognizer? = nil) {
        UIView.animate(withDuration: 0.5, animations: {
            self.notifireView.frame.origin.y = CGFloat(-30 + self.hNav)
        }) { _ in
            UIView.animate(withDuration: 0.4, animations: {
                self.notifireView.frame.origin.y = (CGFloat)(-self.overLap + self.hNav)
            })
            self.timerNotifire = Timer.scheduledTimer(timeInterval: TimeInterval(self.timer), target: self, selector: #selector(self.dismiss), userInfo: nil, repeats: false)
        }
    }
    
    @objc private func dismiss() {
        timerNotifire?.invalidate()
        UIView.animate(withDuration: 0.4, animations: {
            self.notifireView.frame.origin.y = CGFloat(-30 + self.hNav)
        }) { _ in
            UIView.animate(withDuration: 0.4, animations: {
                self.notifireView.frame.origin.y = -(CGFloat(self.height + self.overLap))
            }, completion: { _ in
                self.notifireView.removeFromSuperview()
                self.isShow = false
                self.completion?()
                self.completion = nil
            })
        }
    }
}



extension UIViewController {
    func topMostViewController() -> UIViewController {
        if self.presentedViewController == nil {
            return self
        }
        if let navigation = self.presentedViewController as? UINavigationController {
            if let visibleViewController = navigation.visibleViewController {
                return visibleViewController
            }
            return navigation
        }
        if let tab = self.presentedViewController as? UITabBarController {
            if let selectedTab = tab.selectedViewController {
                return selectedTab.topMostViewController()
            }
            return tab.topMostViewController()
        }
        return self.presentedViewController!.topMostViewController()
    }
}

extension UIApplication {
    func topMostViewController() -> UIViewController? {
        return self.keyWindow?.rootViewController?.topMostViewController()
    }
}

public enum NotifireType {
    case info
    case warning
    case error
}
