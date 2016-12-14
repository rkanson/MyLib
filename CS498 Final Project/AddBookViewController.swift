//
//  AddBookViewController.swift
//  CS498 Final Project
//
//  Created by Rich Kanson on 12/9/16.
//  Copyright © 2016 Richard Kanson. All rights reserved.
//

import Firebase
import UIKit

class AddBookViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var coverImage: UIImageView!
    @IBOutlet var bookTitleTextField: UITextField!
    @IBOutlet var authorTextField: UITextField!
    
    @IBAction func takePhotoAction(sender: UIButton) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .Camera
        presentViewController(picker, animated: true, completion: nil)
    }
    
    @IBAction func selectPhotoAction(sender: UIButton) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .PhotoLibrary
        presentViewController(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        coverImage.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func saveButtonAction(sender: UIButton) {
        let author = authorTextField.text
        let title = bookTitleTextField.text
        let imgName = title! + ".png"
        
        let storageRef = FIRStorage.storage().reference().child(imgName)
        if let uploadData = UIImagePNGRepresentation(coverImage.image!) {
            storageRef.putData(uploadData, metadata: nil, completion: { (metadata, error) in
                if error != nil {
                    print(error)
                    return
                }
                if let coverIMGURL = metadata?.downloadURL()?.absoluteString {
                    let book: [String: AnyObject] = ["author": author!, "title": title!, "coverURL": coverIMGURL]
                    let ref = FIRDatabase.database().reference()
                    let key = ref.child("books").childByAutoId().key
                    ref.child("library").child(key).setValue(book)
                }
            })
        }
        
        navigationController!.popViewControllerAnimated(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
