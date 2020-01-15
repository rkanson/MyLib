//
//  BookDetailViewController.swift
//  CS498 Final Project
//
//  Created by Rich Kanson on 12/12/16.
//  Copyright © 2016 Richard Kanson. All rights reserved.
//

import Firebase
import UIKit

class BookDetailViewController: UIViewController {
    
    @IBOutlet var titleField: UITextField!
    @IBOutlet var authorField: UITextField!
    @IBOutlet var coverImage: UIImageView!
    
    var bTitle: String!
    var author: String!
    var coverURL: String!
    var key: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleField.text = bTitle
        authorField.text = author
        
        if let url = NSURL(string: coverURL) {
            if let data = NSData(contentsOf: url as URL) {
                coverImage.image = UIImage(data: data as Data)
            }
        }
        
    }
    
}
