//
//  SearchViewController.swift
//  CS498 Final Project
//
//  Created by Rich Kanson on 12/13/16.
//  Copyright © 2016 Richard Kanson. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    @IBOutlet var webView: UIWebView!
    
    override func viewDidLoad() {
        let url = NSURL (string: "https://www.amazon.com/gp/aw/ref=aw_c_gw")
        let requestObj = NSURLRequest(url: url! as URL)
        webView.loadRequest(requestObj as URLRequest)
    }
}
