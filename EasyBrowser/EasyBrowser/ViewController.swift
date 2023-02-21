//
//  ViewController.swift
//  EasyBrowser
//
//  Created by Halil Ibrahim Andic on 21.02.2023.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKNavigationDelegate {

    var webView: WKWebView!
    
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }


}

