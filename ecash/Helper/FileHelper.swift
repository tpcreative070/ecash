//
//  FileHelper.swift
//  ecash
//
//  Created by phong070 on 8/5/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import Foundation
enum StoreFolder: String {
    case Documents = "documents"
}

class FileHelper: NSObject {
    
    /**
     listFileOfDirectory
     */
    public static func listFileOfDirectory(inFolder: String) -> [URL]? {
        let fileManager = FileManager.default
        let documentsURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent(inFolder)
        do {
            let fileURLs = try fileManager.contentsOfDirectory(at: documentsURL!, includingPropertiesForKeys: nil)
            return fileURLs
            // process files
        } catch {
            print("Could not clear temp folder: \(error)")
            return nil
        }
    }
    
    /**
     remove file with prefix of file
     */
    public static func removeFileWithPrefix(file: URL, identify: String) {
        let fileManager = FileManager.default
        do {
            if file.lastPathComponent.hasPrefix("\(identify)_") {
                try fileManager.removeItem(atPath: file.path)
            }
        } catch {
            
        }
    }
    
    /**
     isExistFile
     */
    public static func isExistFile(path: String) -> Bool {
        return FileManager.default.fileExists(atPath: path)
    }
}
