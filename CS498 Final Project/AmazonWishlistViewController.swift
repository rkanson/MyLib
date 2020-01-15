//
//  AmazonWishlistViewController.swift
//  CS498 Final Project
//
//  Created by Rich Kanson on 12/14/16.
//  Copyright © 2016 Richard Kanson. All rights reserved.
//

import UIKit

class AmazonWishlistViewController: UIViewController {
    
    @IBOutlet var webView: UIWebView!
    let amazon = "https://www.amazon.com/gp/aw/s/ref=is_box_?k="
    var bTitle: String! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let bookURL = amazon + bTitle
        let newBookURL: String = bookURL.replacingOccurrences(of: " ", with: "%20")
        UIWebView.loadRequest(webView)(NSURLRequest(url: NSURL(string: newBookURL)! as URL) as URLRequest)
    }
    
}
