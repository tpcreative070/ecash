//
//  UIView+InputAssistant.swift
//  vietlifetravel
//
//  Created by Mac10 on 6/26/19.
//  Copyright © 2019 Mac10. All rights reserved.
//

import UIKit
extension UIView{
    /**
     Fix issue warning autolayout in ipad device
     */
    func fixInputAssistant(){
        for subview in self.subviews{
            if type(of: subview) is UITextField.Type{
                let item = (subview as! UITextField).inputAssistantItem
                item.leadingBarButtonGroups = []
                item.trailingBarButtonGroups = []
            }
            else if subview.subviews.count > 0{
                subview.fixInputAssistant()
            }
        }
    }
}
