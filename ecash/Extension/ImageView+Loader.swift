//
//  ImageView+Loader.swift
//  ecash
//
//  Created by phong070 on 8/5/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import UIKit
import Foundation
open class CachedImageView: UIImageView {
    let indicator = UIActivityIndicatorView.init(style: .gray)
    
    var sessionId: String {
        return CommonService.getCurrentSessionId()!
    }
    var defaultContentType: String {
        return "application/json"
    }
    
    public static let imageCache = NSCache<NSString, DiscardableImageCacheItem>()
    
    open var shouldUseEmptyImage = true
    
    private var urlStringForChecking: String?
    private var emptyImage: UIImage?
    
    public convenience init(cornerRadius: CGFloat = 0, tapCallback: @escaping (() ->())) {
        self.init(cornerRadius: cornerRadius, emptyImage: nil)
        self.tapCallback = tapCallback
        isUserInteractionEnabled = true
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
    }
    
    @objc func handleTap() {
        tapCallback?()
    }
    
    private var tapCallback: (() -> ())?
    
    public init(cornerRadius: CGFloat = 0, emptyImage: UIImage? = nil) {
        super.init(frame: .zero)
        contentMode = .scaleAspectFill
        clipsToBounds = true
        layer.cornerRadius = cornerRadius // cornerRadius
        self.emptyImage = emptyImage
        self.addSubview(indicator)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            indicator.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            indicator.centerYAnchor.constraint(equalTo: self.centerYAnchor)])
        indicator.hidesWhenStopped = true
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setEmptyImage(image: UIImage?) {
        self.emptyImage = image
    }
    
    /**
     Easily load an image from a URL string and cache it to reduce network overhead later.
     
     - parameter urlString: The url location of your image, usually on a remote server somewhere.
     - parameter completion: Optionally execute some task after the image download completes
     */
    
    open func loadImage(urlString: String, completion: (() -> ())? = nil) {
        
        image = nil
        self.urlStringForChecking = urlString
        
        let urlKey = urlString as NSString
        
        if let cachedItem = CachedImageView.imageCache.object(forKey: urlKey) {
            image = cachedItem.image
            completion?()
            return
        }
        
        guard let url = URL(string: urlString) else {
            if shouldUseEmptyImage {
                image = emptyImage
            }
            return
        }
        /*
         Adding header to urlRequest
         */
        var requestUrl = URLRequest(url: url)
        requestUrl.setValue(defaultContentType, forHTTPHeaderField: "Content-Type")
        requestUrl.setValue(sessionId, forHTTPHeaderField: "sessionId")
        
        indicator.startAnimating()
        
        URLSession.shared.dataTask(with: requestUrl, completionHandler: { [weak self] (data, response, error) in
            DispatchQueue.main.async {
                guard let `self` = self else  {
                    return
                }
                self.indicator.stopAnimating()
                if error != nil {
                    if self.shouldUseEmptyImage {
                        self.image = self.emptyImage
                    }
                    return
                }
                if let image = UIImage(data: data!) {
                    let cacheItem = DiscardableImageCacheItem(image: image)
                    CachedImageView.imageCache.setObject(cacheItem, forKey: urlKey)
                    if urlString == self.urlStringForChecking {
                        self.alpha = 0
                        self.image = image
                        UIView.animate(withDuration: 0.2, animations: {
                            self.alpha = 1
                        })
                        completion?()
                    }
                } else {
                    self.image = self.emptyImage
                }
            }
            
        }).resume()
    }
}
