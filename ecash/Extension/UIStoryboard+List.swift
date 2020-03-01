//
//  UIStoryboard+List.swift
//  vietlifetravel
//
//  Created by Mac10 on 6/25/19.
//  Copyright © 2019 Mac10. All rights reserved.
//

import UIKit
extension UIStoryboard {
    @nonobjc class var main: UIStoryboard {
        return UIStoryboard(name: Storyboard.main, bundle: nil)
    }
    
    @nonobjc class var author: UIStoryboard {
        return UIStoryboard(name: Storyboard.author, bundle: nil)
    }
    
    @nonobjc class var settings: UIStoryboard {
        return UIStoryboard(name: Storyboard.settings, bundle: nil)
    }
    
    @nonobjc class var lixi: UIStoryboard {
        return UIStoryboard(name: Storyboard.lixi, bundle: nil)
    }
}
