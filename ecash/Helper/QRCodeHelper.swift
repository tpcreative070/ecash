//
//  QRCodeHelper.swift
//  ecash
//
//  Created by phong070 on 10/17/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import ZXingObjC
import UIKit

class QRCodeHelper : NSObject {
    //<Số ví đích>_<NgàyGiờChuyển>_<Số thứ tự QR>
    static let shared =  QRCodeHelper()
    
    func generateDataQRCode(from string: String) -> UIImage? {
        do {
            let writer = ZXMultiFormatWriter()
            let hints = ZXEncodeHints() as ZXEncodeHints
            /*
             NSASCIIStringEncoding = 1,        /* 0..127 only */
             NSNEXTSTEPStringEncoding = 2,
             NSJapaneseEUCStringEncoding = 3,
             NSUTF8StringEncoding = 4,
             NSISOLatin1StringEncoding = 5,
             NSSymbolStringEncoding = 6,
             NSNonLossyASCIIStringEncoding = 7,
             NSShiftJISStringEncoding = 8,          /* kCFStringEncodingDOSJapanese */
             NSISOLatin2StringEncoding = 9,
             NSUnicodeStringEncoding = 10,
             NSWindowsCP1251StringEncoding = 11,    /* Cyrillic; same as AdobeStandardCyrillic */
             NSWindowsCP1252StringEncoding = 12,    /* WinLatin1 */
             NSWindowsCP1253StringEncoding = 13,    /* Greek */
             NSWindowsCP1254StringEncoding = 14,    /* Turkish */
             NSWindowsCP1250StringEncoding = 15,    /* WinLatin2 */
             NSISO2022JPStringEncoding = 21,        /* ISO 2022 Japanese encoding for e-mail */
             NSMacOSRomanStringEncoding = 30,
             */
            // hints.encoding = 4
            hints.encoding = String.Encoding.utf8.rawValue
            let result = try writer.encode(string, format: kBarcodeFormatQRCode, width: 500, height: 500, hints: hints)
            if let imageRef = ZXImage.init(matrix: result) {
                if let image = imageRef.cgimage {
                    return UIImage.init(cgImage: image)
                }
            }
        }
        catch {
            print(error)
        }
        return nil
    }
    
    func writeFile(data : Data, fileName : String){
        guard let _ = DocumentHelper.getFilePath(fileName: fileName,folderName: FolderName.gallery) else {
            DocumentHelper.createdFile(data: data, folderName: FolderName.gallery,fileName: fileName)
            debugPrint("eWalletCipher.db was created")
            return
        }
    }
    
    func getFiles(folderName : String) -> [FilesModel]?{
        guard let mUrl = DocumentHelper.getFile(folderName: folderName) else {
            return nil
        }
        let mResult = mUrl.map { (result) -> FilesModel in
            return FilesModel(name: result.lastPathComponent , path: result.path)
        }
        return mResult
    }
    
    func saveImage(image: UIImage,fileName : String) -> Bool {
        guard let data = image.jpegData(compressionQuality: 100) ?? image.pngData() else {
            return false
        }
        return DocumentHelper.createdFile(data: data, folderName: FolderName.gallery,fileName: fileName)
    }
    
    func deleteFile(pathName : String){
        DocumentHelper.deletedFile(pathName: pathName)
    }
}
