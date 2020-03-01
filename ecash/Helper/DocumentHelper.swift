//
//  DocumentHelper.swift
//  ecast
//
//  Created by phong070 on 7/25/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//
import UIKit
class DocumentHelper {
    
    open class func loadBundle(fileName : String, mExtension : String) -> Data?{
        if let path = Bundle.main.path(forResource:fileName, ofType: mExtension) {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                return data
        
            } catch {
                debugPrint("Catch...")
            }
            //0123456789ABCDEFGHIJKL0123456789
        }
        return nil
    }
    
    open class func loadBundleString(fileName : String, mExtension : String) -> String?{
        if let path = Bundle.main.path(forResource:fileName, ofType: mExtension) {
            return path
        }
        return nil
    }
       
    open class func getFilePath(fileName : String, folderName : String? = nil) -> URL?{
        let fileManager = FileManager.default
        do {
            let documentDirectory = try fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor:nil, create:false)
            guard let mFolderName = folderName else {
                let fileURL = documentDirectory.appendingPathComponent(fileName)
                if fileManager.fileExists(atPath: fileURL.path){
                    return fileURL
                }else{
                    return nil
                }
            }
            let fileURL = documentDirectory.appendingPathComponent(mFolderName, isDirectory: true).appendingPathComponent(fileName)
            if fileManager.fileExists(atPath: fileURL.path){
                return fileURL
            }else{
                return nil
            }
        } catch {
            print(error)
        }
        return nil
    }
    
    open class func getFile(folderName : String? = nil) -> [URL]?{
        let fileManager = FileManager.default
        let documentsURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        do {
            var documentDirectory = try fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor:nil, create:false)
            guard let mFolder = folderName else {
                return nil
            }
            documentDirectory = documentDirectory.appendingPathComponent(mFolder)
            let fileURLs = try fileManager.contentsOfDirectory(at: documentDirectory, includingPropertiesForKeys: nil)
            // process files
            return fileURLs
        } catch {
            print("Error while enumerating files \(documentsURL.path): \(error.localizedDescription)")
        }
        return nil
    }
    
    open class func createdFile(data : Data, folderName : String? = nil,fileName : String)-> Bool{
        let fileManager = FileManager.default
        do {
            var documentDirectory = try fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor:nil, create:false)
            guard let mFolder = folderName else {
                let fileURL = documentDirectory.appendingPathComponent(fileName)
                try data.write(to: fileURL)
                return true
            }
            documentDirectory = documentDirectory.appendingPathComponent(mFolder)
            do {
                try FileManager.default.createDirectory(atPath: documentDirectory.path, withIntermediateDirectories: true, attributes: nil)
            } catch let error as NSError {
                print("Error creating directory: \(error.localizedDescription)")
            }
            let fileURL = documentDirectory.appendingPathComponent(fileName)
            try data.write(to: fileURL)
            return true
        } catch {
            print(error)
        }
        return false
    }
    
    open class func deletedFile(pathName : String){
        let fileManager = FileManager.default
        // Delete 'hello.swift' file
        do {
            try fileManager.removeItem(atPath: pathName)
        }
        catch{
            print("Ooops! Something went wrong: \(error)")
        }
    }
    
}
