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
        
        
        let fakeAction1 = FakeNavigationAction(testRequest: URLRequest.init(url: URL(string: "https://www.walmart.com/plus/address")!))
        vc.webView(vc.webView, decidePolicyFor: fakeAction1, decisionHandler: { receivedPolicy = $0 })
        XCTAssertEqual(receivedPolicy, WKNavigationActionPolicy.cancel)

        
        let fakeAction2 = FakeNavigationAction(testRequest: URLRequest.init(url: URL(string: "https://www.walmart.com/plus/signup")!))
        vc.webView(vc.webView, decidePolicyFor: fakeAction2, decisionHandler: { receivedPolicy = $0 })
        XCTAssertEqual(receivedPolicy, WKNavigationActionPolicy.cancel)

        
        let fakeAction3 = FakeNavigationAction(testRequest: URLRequest.init(url: URL(string: "https://www.walmart.com/plus/trial")!))
        vc.webView(vc.webView, decidePolicyFor: fakeAction3, decisionHandler: { receivedPolicy = $0 })
        XCTAssertEqual(receivedPolicy, WKNavigationActionPolicy.cancel)
        
        let fakeAction4 = FakeNavigationAction(testRequest: URLRequest.init(url: URL(string: "https://www.walmart.com/signin")!))
        vc.webView(vc.webView, decidePolicyFor: fakeAction4, decisionHandler: { receivedPolicy = $0 })
        XCTAssertEqual(receivedPolicy, WKNavigationActionPolicy.allow)
        
        let fakeAction6 = FakeNavigationAction(testRequest: URLRequest.init(url: URL(string: "https://tap.walmart.com/signin")!))
        vc.webView(vc.webView, decidePolicyFor: fakeAction6, decisionHandler: { receivedPolicy = $0 })
        XCTAssertEqual(receivedPolicy, WKNavigationActionPolicy.allow)
        
        let fakeAction5 = FakeNavigationAction(testRequest: URLRequest.init(url: URL(string: "https://www.google.com")!))
        vc.webView(vc.webView, decidePolicyFor: fakeAction5, decisionHandler: { receivedPolicy = $0 })
        XCTAssertEqual(receivedPolicy, WKNavigationActionPolicy.cancel)
    }
    
    func testHandleUrl(){
        let vc = getVC(storyboardName: "Main",controller: ViewController.init())
        let val1 = vc.handleInterceptWithUrlString(url: "www.walmart.com/signin", host: "www.walmart.com")
        XCTAssertFalse(val1)
        
        let val2 = vc.handleInterceptWithUrlString(url: "www.walmart.com/signin", host: nil)
        XCTAssertTrue(val2)
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
