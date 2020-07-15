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
        
        let url = URL(string: Paths.baseUrl.rawValue)!
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
    }


}

extension ViewController:WKNavigationDelegate{
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        print("URL navigated :\(String(describing: navigationAction.request.url))")
        
        handleUrl(urlString: navigationAction.request.url?.absoluteString) ? decisionHandler(.cancel) : decisionHandler(.allow)
    }
}

extension ViewController {
    enum Paths:String {
        case baseUrl = "https://www.hackingwithswift.com"
        case k = "/forums"
        case l = "/example-code"
        case m = "/learn"
    }
    
    private func handleUrl(urlString: String?)->Bool {
        if let url = urlString {
            if url.contains(Paths.k.rawValue) || url.contains(Paths.l.rawValue) || url.contains(Paths.m.rawValue) {
                return true
            }
        }
        
        return false
    }
}
