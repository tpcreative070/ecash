//
//  UINavigationController+Container.swift
//  ecash
//
//  Created by phong070 on 10/17/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import UIKit
extension UINavigationController {
    public func hasViewController(ofKind kind: AnyClass) -> UIViewController? {
        return self.viewControllers.first(where: {$0.isKind(of: kind)})
    }
}
