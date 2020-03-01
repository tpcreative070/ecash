//
//  Download.swift
//  ecash
//
//  Created by phong070 on 8/5/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import Foundation
class DownloadModel: NSObject {
    var node: DocumentModel
    init(node: DocumentModel) {
        self.node = node
    }
    // Download service sets these values:
    var task: URLSessionDownloadTask?
    var isDownloading = false
    var resumeData: Data?
    
    // Download delegate sets this value:
    var progress: Float = 0
}
