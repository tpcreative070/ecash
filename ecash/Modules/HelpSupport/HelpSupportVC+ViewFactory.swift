//
//  HelpSupportVC+ViewFactory.swift
//  ecash
//
//  Created by phong070 on 12/3/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import UIKit
import WebKit
extension HelpSupportVC {
    
    func setupWebview() {
        let webview = WKWebView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height))
        self.viewLoading.addSubview(webview)
        let url = URL(string: defaultUrl)
        webview.navigationDelegate = self
        webview.load(URLRequest(url: url!))
        ProgressHUD.showInView(view: self.view)
    }
}

extension HelpSupportVC: WKNavigationDelegate, WKUIDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        ProgressHUD.dismiss()
    }
             
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        ProgressHUD.dismiss()
    }
}
   
