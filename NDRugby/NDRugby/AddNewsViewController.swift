//
//  AddNewsViewController.swift
//  NDRugby
//
//  Created by Katie Loughran on 4/27/16.
//  Copyright © 2016 Katie Loughran. All rights reserved.
//

import UIKit
import MobileCoreServices

class AddNewsViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var onDataAvailable : ((message: Message) -> ())?
    
    @IBOutlet weak var updatePhoto: UIImageView!
    @IBOutlet weak var updateText: UITextView!
    @IBOutlet weak var updateToolbar: UIToolbar!
    @IBOutlet weak var updateTextField: UITextField!
    @IBOutlet weak var cameraButtonOutlet: UIBarButtonItem!
    @IBOutlet weak var bottomContraint: NSLayoutConstraint!
    
    var textContraint:CGFloat?
    var username:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let x:CGFloat = 0
        let y:CGFloat = 0
        self.updateTextField.frame = CGRect(x: x, y: y, width: self.updateToolbar.frame.size.width/2 - self.cameraButtonOutlet.width*2 - 25, height: self.updateToolbar.frame.size.height-10)
        
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ShareViewController.keyboardWillShow(_:)), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ShareViewController.keyboardWillHide(_:)), name: UIKeyboardWillHideNotification, object: nil)
        
        self.updateTextField.delegate = self;
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ShareViewController.tapDismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    
    func tapDismissKeyboard() {
        self.view.endEditing(true)
    }
    
     func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
     }
     
     func keyboardWillShow(notification: NSNotification) {
        var info = notification.userInfo!
        let keyboardFrame: CGRect = (info[UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue()
        self.textContraint = self.bottomContraint.constant
        UIView.animateWithDuration(1.0, animations: { () -> Void in
            self.bottomContraint.constant = keyboardFrame.size.height
     
        })
     }
    
     func keyboardWillHide(notification : NSNotification) {
        if let constraint = self.textContraint{
            self.bottomContraint.constant = constraint
        }
     }
 
    
    
    @IBAction func cancelButton(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    @IBAction func updateButton(sender: AnyObject) {
        let newMessage = Message(text: self.updateText.text, user: username!)
        newMessage.date = NSDate()
        if let image = self.updatePhoto.image{
            newMessage.image = image
        }
        

        self.onDataAvailable?(message: newMessage)
        //send info / prepare for segue
        
        dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func addTextButton(sender: AnyObject) {
        self.updateText.text = self.updateTextField.text
        self.view.endEditing(true)
    }
    
    @IBAction func cameraButton(sender: UIBarButtonItem) {
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
        }else{
            print("Camera Not Available")
        }
        
    }
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        let mediaType = info[UIImagePickerControllerMediaType] as! String
        self.dismissViewControllerAnimated(true, completion: nil)
        
        if mediaType == (kUTTypeImage as String) {
            let image = info[UIImagePickerControllerOriginalImage]
                as! UIImage
            self.updatePhoto.image = image
        }
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
