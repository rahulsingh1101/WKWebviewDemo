//
//  ViewController.swift
//  WKWebViewDemo
//
//  Created by Ajeet N on 15/07/20.
//  Copyright © 2020 Ajeet N. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController {
    var webView: WKWebView!
    
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string: "https://www.walmart.com")!
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
    }
}

extension ViewController:WKNavigationDelegate{
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        print("URL :\(String(describing: navigationAction.request.url))")
        
        let url = navigationAction.request.url?.absoluteString
        let urlHost = navigationAction.request.url?.host
        
        let isIntercepted = self.handleInterceptWithUrlString(url: url, host: urlHost)
        
        if isIntercepted {
            decisionHandler(.cancel)
            return
        }

        /// if html's link is <a href="_blank"...> then try to open in same page
        if navigationAction.targetFrame == nil {
            webView.load(navigationAction.request)
        }
        decisionHandler(.allow)
    }
}

extension ViewController {
    enum Paths:String {
        case kWMAddressPath = "/plus/address"
        case kWMSignUpPath = "/plus/signup"
        case kWMTrialPath = "/plus/trial"
    }
    
    func handleInterceptWithUrlString(url: String?, host: String?) -> Bool {
        guard let host = host, let url = url else {
            return true
        }
        
        guard host.hasSuffix(".walmart.com") else {
            return true
        }
        
        if url.contains(Paths.kWMAddressPath.rawValue) || url.contains(Paths.kWMSignUpPath.rawValue) || url.contains(Paths.kWMTrialPath.rawValue) {
            return true
        }
        return false
    }
}
