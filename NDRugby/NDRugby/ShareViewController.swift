//
//  ShareViewController.swift
//  NDRugby
//
//  Created by Katie Loughran on 4/6/16.
//  Copyright © 2016 Katie Loughran. All rights reserved.
//

import UIKit
import MobileCoreServices

class ShareViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    var messages:[Message] = []
    var sendImage:UIImage?
    var textContraint:CGFloat?
    var prevButtonContraint:CGFloat?
    let fb = FireBaseService();


    @IBOutlet weak var toolBarConstraint: NSLayoutConstraint!
    
    @IBAction func cameraAction(sender: AnyObject) {
        if UIImagePickerController.isSourceTypeAvailable(
            UIImagePickerControllerSourceType.PhotoLibrary) {
            
            let imagePicker = UIImagePickerController()
            
            imagePicker.delegate = self
            imagePicker.sourceType =
                UIImagePickerControllerSourceType.PhotoLibrary
            imagePicker.mediaTypes = [kUTTypeImage as NSString as String]
            imagePicker.allowsEditing = false
            
            self.presentViewController(imagePicker, animated: true,
                                       completion: nil)
            //newMedia = true
        }else{
            print("Camera Not Available")
        }
    }

    @IBAction func shareButton(sender: UIBarButtonItem) {
        let newMessage = Message(text: messageField.text!, user: messageField.text!)
        newMessage.image = self.sendImage
        newMessage.date = NSDate()
        fb.sendMessage(newMessage)
        messageField.text! = ""
        self.sendImage = nil
        self.tableView.reloadData()
    }
    

    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        let mediaType = info[UIImagePickerControllerMediaType] as! String
        
        self.dismissViewControllerAnimated(true, completion: nil)
        
        if mediaType == (kUTTypeImage as String) {
            let image = info[UIImagePickerControllerOriginalImage]
                as! UIImage
            self.sendImage = image
            
        }
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    @IBOutlet weak var messageField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    func keyboardWillShow(notification: NSNotification) {
        var info = notification.userInfo!
        let keyboardFrame: CGRect = (info[UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue()
        self.textContraint = self.toolBarConstraint.constant
        UIView.animateWithDuration(0.1, animations: { () -> Void in
            self.toolBarConstraint.constant = keyboardFrame.size.height + 20

        })
    }
    func keyboardWillHide(notification : NSNotification) {
        if let constraint = self.textContraint{
            self.toolBarConstraint.constant = constraint
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ShareViewController.keyboardWillShow(_:)), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ShareViewController.keyboardWillHide(_:)), name: UIKeyboardWillHideNotification, object: nil)
        self.messageField.delegate = self;
        
        fb.shareMessages{
            (message) in
            self.messages.append(message)
            self.tableView.reloadData()
        }
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ShareViewController.tapDismissKeyboard))
        view.addGestureRecognizer(tap)
        
        self.tableView.rowHeight = 317

    }
    
    func tapDismissKeyboard() {
        view.endEditing(true)
    }
    


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //Message With Image
        if (self.messages[indexPath.row].image) != nil{
            //print("Image")
            let cell = tableView.dequeueReusableCellWithIdentifier("imageCell", forIndexPath: indexPath) as! MediaTableViewCell
            //TEXT
            if let label = cell.shareLabel{
                label.text = self.messages[indexPath.row].text
            }
            //IMAGE
            //let image = UIImage(named:"temp_label")
            let image = messages[indexPath.row].image
            cell.shareImage.image = image
            return cell
        }
        //Message W/O Image
        else{
            //print("No Image")
            let cell = tableView.dequeueReusableCellWithIdentifier("shareCell", forIndexPath: indexPath) as! PlainMessageTableViewCell
            if let label = cell.shareLabel{
                label.text = self.messages[indexPath.row].text
            }
            /*if let label = cell.nameLabel{
                label.text = "Katie"
            }*/
            return cell
        }
        
    }
    


}
