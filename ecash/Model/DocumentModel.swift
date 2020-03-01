//
//  DocumentModel.swift
//  ecash
//
//  Created by phong070 on 8/5/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import Foundation
let documentsPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!

class DocumentModel {
    var fileName : String
    var type : String
    var linkURL: URL?
    init(fileName : String, type : String, url : String) {
        self.fileName = fileName
        self.linkURL = URL(string: url)
        self.type = type
    }
    
    func getPathLocal() -> URL {
        let directory = "\(StoreFolder.Documents.rawValue)/\("Document")_\(fileName).\(type)"
        return documentsPath.appendingPathComponent(directory)
    }
    
    required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
}
