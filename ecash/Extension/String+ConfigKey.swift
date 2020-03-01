//
//  String+ConfigKey.swift
//  ecash
//
//  Created by phong070 on 8/1/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import Foundation
extension String {
    func infoForKey() -> String? {
        return (Bundle.main.infoDictionary?[self] as? String)?
            .replacingOccurrences(of: "\\", with: "")
    }
}
