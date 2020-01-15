//
//  LibraryTableViewController.swift
//  CS498 Final Project
//
//  Created by Rich Kanson on 12/9/16.
//  Copyright © 2016 Richard Kanson. All rights reserved.
//

import Firebase
import UIKit

struct bookStruct {
    let title: String!
    let author: String!
    let coverURL: String!
}

class LibraryTableViewController: UITableViewController {
    
    var books = [bookStruct]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let ref = FIRDatabase.database().reference()
        let user = FIRAuth.auth()?.currentUser?.uid
        ref.child("library").child(user!).queryOrderedByKey().observe(.childAdded, with: { snapshot in
            let title = snapshot.value!["title"]
            let author = snapshot.value!["author"]
            let coverURL = snapshot.value!["coverURL"]
            self.books.insert(bookStruct(title: title, author: author, coverURL: coverURL), atIndex: 0)
            self.tableView.reloadData()
        })
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "libraryCell", for: indexPath as IndexPath)
        cell.textLabel?.text = books[indexPath.row].title
        cell.detailTextLabel?.text = books[indexPath.row].author
        if let url = NSURL(string: books[indexPath.row].coverURL) {
            if let data = NSData(contentsOf: url as URL) {
                cell.imageView?.image = UIImage(data: data as Data)
            }
        }
        return cell
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
   func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.delete) {
//            books.removeAtIndex(indexPath.row)
            self.tableView.reloadData()
        }
    }
    
    func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "librarySegue" {
            let destination = segue.destination as? BookDetailViewController
            let indexPath = tableView.indexPathForSelectedRow!
            let bTitle = books[indexPath.row].title
            let author = books[indexPath.row].author
            destination?.bTitle = bTitle
            destination?.author = author
            destination?.coverURL = books[indexPath.row].coverURL
        }
    }

}
