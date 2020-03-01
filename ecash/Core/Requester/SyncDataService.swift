//
//  SyncService.swift
//  ecash
//
//  Created by phong070 on 8/5/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import UIKit
import Foundation
class SyncDataService : NSObject, APIClient{
    static let shared = SyncDataService()
    var activeDownloads: [URL: DownloadModel] = [:]
    var downloadDelegate: DownloadDelegate?
    var session: URLSession!
    private init(configuration: URLSessionConfiguration) {
        super.init()
        self.session = URLSession(configuration: configuration,delegate: self,delegateQueue: nil)
    }
    
    private convenience override init() {
        self.init(configuration: .default)
    }
    
    /**
     Streaming update file
    */
    lazy var boundStreams: Streams = {
        var inputOrNil: InputStream? = nil
        var outputOrNil: OutputStream? = nil
        Stream.getBoundStreams(withBufferSize: 4096,
                               inputStream: &inputOrNil,
                               outputStream: &outputOrNil)
        guard let input = inputOrNil, let output = outputOrNil else {
            fatalError("On return of `getBoundStreams`, both `inputStream` and `outputStream` will contain non-nil streams.")
        }
        // configure and open output stream
        output.delegate = self
        output.schedule(in: .current, forMode: .default)
        output.open()
        return Streams(input: input, output: output)
    }()
    
    /**
     Uploading file
    */
    func streamingUploadFile(data : SyncDataRequestModel){
        let url = URL(string: data.url)!
        var request = URLRequest(url: url,
                                 cachePolicy: .reloadIgnoringLocalCacheData,
                                 timeoutInterval: 10)
        request.httpMethod = "GET"
        request.httpBodyStream = InputStream(fileAtPath: data.pathFile)
        let boundary = "TestBoundary"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        let uploadTask = session.uploadTask(withStreamedRequest: request)
        uploadTask.resume()
    }
    
    /**
     updating files
     */
    func updateUserAvatar(userId: Int, image: UIImage, completion: @escaping (Result<EmptyModel?, APIServiceError>) -> Void) {
        let user = SyncEndPoint.upload
        let path = user.path.replacingOccurrences(of: "{userId}", with: String(userId))
        var errorDetail = APIServiceError(errorDetail: nil, message: "", code: 0)
        
        // Modify url
        var urlComponents: URLComponents {
            var components = URLComponents(string: user.base)!
            components.path = path
            return components
        }
        var request = user.request
        request.httpMethod = HTTPMethod.POST.rawValue
        request.url = urlComponents.url
        
        // Set body data
        let imageData = image.pngData()
        let boundary = "TestBoundary"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        let fullData = photoDataToFormData(data: imageData!, boundary: boundary, fileName: CommonService.createFileName(), key: "photo")
        request.httpBody = fullData
        fetch(with: request, decode: { json -> EmptyModel? in
            guard let authResult = json as? EmptyModel else { return  nil }
            return authResult
        }, completion: completion)
    }
    
    func photoDataToFormData(data: Data,boundary: String,fileName: String,key: String) -> Data {
        let fullData = NSMutableData()
        
        // 1 - Boundary should start with --
        let lineOne = "--" + boundary + "\r\n"
        fullData.append(lineOne.data(
            using: String.Encoding.utf8,
            allowLossyConversion: false)!)
        
        // 2
        let lineTwo = "Content-Disposition: form-data; name=\"" + key + "\"; filename=\"" + fileName + "\"\r\n"
        fullData.append(lineTwo.data(
            using: String.Encoding.utf8,
            allowLossyConversion: false)!)
        
        // 3
        let lineThree = "Content-Type: image/jpg\r\n\r\n"
        fullData.append(lineThree.data(
            using: String.Encoding.utf8,
            allowLossyConversion: false)!)
        
        // 4
        
        // 5
        let lineFive = "\r\n"
        fullData.append(lineFive.data(
            using: String.Encoding.utf8,
            allowLossyConversion: false)!)
        
        // 6 - The end. Notice -- at the start and at the end
        let lineSix = "--" + boundary + "--\r\n"
        fullData.append(lineSix.data(
            using: String.Encoding.utf8,
            allowLossyConversion: false)!)
        
        return fullData as Data
    }
    
    /**
     Downloading files
     */
    func startDownload(_ node: DocumentModel) {
        guard  let linkURL = node.linkURL else {
            return
        }
        if let download = activeDownloads[linkURL], download.isDownloading == true {
            return
        }
        let download = DownloadModel(node: node)
        let request = URLRequest(url: linkURL)
        download.task = session.downloadTask(with: request)
        download.task!.resume()
        download.isDownloading = true
        activeDownloads[linkURL] = download
    }
    
    func pauseDownload(_ node: DocumentModel) {
        guard let linkURL = node.linkURL,let download = activeDownloads[linkURL] else { return }
        if download.isDownloading {
            download.task?.cancel(byProducingResumeData: { data in
                download.resumeData = data
            })
            download.isDownloading = false
        }
    }
    
    func cancelDownload(_ node: DocumentModel) {
        if let linkURL = node.linkURL, let download = activeDownloads[linkURL] {
            download.task?.cancel()
            activeDownloads[linkURL] = nil
        }
    }
    
    func resumeDownload(_ node: DocumentModel) {
        guard let linkURL = node.linkURL, let download = activeDownloads[linkURL] else { return }
        if let resumeData = download.resumeData {
            download.task = session.downloadTask(withResumeData: resumeData)
        } else {
            download.task = session.downloadTask(with: download.node.linkURL!)
        }
        download.task!.resume()
        download.isDownloading = true
    }
}

extension SyncDataService : URLSessionDelegate {
    
}

extension SyncDataService : URLSessionDownloadDelegate {
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        guard let sourceURL = downloadTask.originalRequest?.url else { return }
        guard let download = SyncDataService.shared.activeDownloads[sourceURL]?.node else {
            debugPrint(sourceURL)
            debugPrint("Node is null \(SyncDataService.shared.activeDownloads)")
            return
        }
        SyncDataService.shared.activeDownloads[sourceURL] = nil
        let destinationURL = download.getPathLocal()
        var documentPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        documentPath.appendPathComponent(StoreFolder.Documents.rawValue)
        do {
            try FileManager.default.createDirectory(atPath: documentPath.path, withIntermediateDirectories: true, attributes: nil)
            try FileManager.default.copyItem(at: location, to: destinationURL)
            try? FileManager.default.setAttributes([FileAttributeKey.protectionKey : FileProtectionType.complete], ofItemAtPath: destinationURL.path)
            downloadDelegate?.complete()
        } catch let error {
            try? FileManager.default.removeItem(at: destinationURL)
            debugPrint("Could not copy file to disk: \(error.localizedDescription)")
        }
    }
    
    // Updates progress info
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask,
                    didWriteData bytesWritten: Int64, totalBytesWritten: Int64,
                    totalBytesExpectedToWrite: Int64) {
        guard let url = downloadTask.originalRequest?.url,
            let download = SyncDataService.shared.activeDownloads[url]  else { return }
        download.progress = Float(totalBytesWritten) / Float(totalBytesExpectedToWrite)
        let totalSize = ByteCountFormatter.string(fromByteCount: totalBytesExpectedToWrite,
                                                  countStyle: .file)
        debugPrint("\(download.progress)  total : \(totalSize)")
    }
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
    }
}

extension SyncDataService  : StreamDelegate {
    func stream(_ aStream: Stream, handle eventCode: Stream.Event) {
        guard aStream == boundStreams.output else {
            return
        }
        if eventCode.contains(.hasSpaceAvailable) {
            debugPrint("Can write")
        }
        if eventCode.contains(.errorOccurred) {
            debugPrint("Error ocurred white uploading...")
            boundStreams.input.close()
            boundStreams.output.close()
            // Close the streams and alert the user that the upload failed.
        }
    }
}

extension SyncDataService : URLSessionTaskDelegate {
    func urlSession(_ session: URLSession, task: URLSessionTask, needNewBodyStream completionHandler: @escaping (InputStream?) -> Void) {
        completionHandler(boundStreams.input)
    }
}
