//
//  WKWebViewDemoTests.swift
//  WKWebViewDemoTests
//
//  Created by Ajeet N on 15/07/20.
//  Copyright © 2020 Ajeet N. All rights reserved.
//

import XCTest
@testable import WKWebViewDemo
import WebKit

class WKWebViewDemoTests: XCTestCase {
    
    func test_RequestPolicy(){
        var receivedPolicy: WKNavigationActionPolicy?

        let vc = getVC(storyboardName: "Main",controller: ViewController.init())
        
        let fakeAction1 = FakeNavigationAction(testRequest: URLRequest.init(url: URL(string: ViewController.Paths.baseUrl.rawValue)!))
        vc.webView(vc.webView, decidePolicyFor: fakeAction1, decisionHandler: { receivedPolicy = $0})
        XCTAssertEqual(receivedPolicy, WKNavigationActionPolicy.allow)
        
        
        let fakeAction2 = FakeNavigationAction(testRequest: URLRequest.init(url: URL(string: ViewController.Paths.k.rawValue)!))
        vc.webView(vc.webView, decidePolicyFor: fakeAction2, decisionHandler: { receivedPolicy = $0})
        XCTAssertEqual(receivedPolicy, WKNavigationActionPolicy.cancel)
        
        
    }
    
    func test_RequestWithCancel() {
        var receivedPolicy: WKNavigationActionPolicy?

        let vc = getVC(storyboardName: "Main",controller: ViewController.init())
        let fakeAction3 = FakeNavigationAction(testRequest: URLRequest.init(url: URL(string: ViewController.Paths.l.rawValue)!))
        vc.webView(vc.webView, decidePolicyFor: fakeAction3, decisionHandler: { receivedPolicy = $0})
        XCTAssertEqual(receivedPolicy, WKNavigationActionPolicy.cancel)
        
        let fakeAction4 = FakeNavigationAction(testRequest: URLRequest.init(url: URL(string: ViewController.Paths.m.rawValue)!))
        vc.webView(vc.webView, decidePolicyFor: fakeAction4, decisionHandler: { receivedPolicy = $0})
        XCTAssertEqual(receivedPolicy, WKNavigationActionPolicy.cancel)
    }
    
    private func getVC<T:UIViewController>(storyboardName: String, controller:T)->T{
        let storyboard: UIStoryboard = UIStoryboard.init(name: storyboardName, bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: String(describing: T.self)) as! T
        vc.loadView()
        return vc
    }
}

final class FakeNavigationAction: WKNavigationAction {
    let testRequest: URLRequest
    
    override var request: URLRequest {
        return testRequest
    }

    init(testRequest: URLRequest) {
        self.testRequest = testRequest
        super.init()
    }
}
