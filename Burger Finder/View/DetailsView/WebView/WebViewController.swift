//
//  WebViewController.swift
//  Burger Finder
//
//  Created by fyz on 1/5/23.
//

import Foundation
import UIKit
import WebKit

class WebViewController: UIViewController {
    
    let webView = WKWebView()
    let webViewModel = WebViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Configure webView
        configureWebView()
        
        
    }
    
}
