//
//  ShareViewController.swift
//  NDRugby
//
//  Created by Katie Loughran on 4/6/16.
//  Copyright © 2016 Katie Loughran. All rights reserved.
//

import UIKit

class ShareViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    var messages:[Message] = []
    var textContraint:CGFloat?
    var prevButtonContraint:CGFloat?
    let fb = FireBaseService();

    @IBOutlet weak var bottomContraint: NSLayoutConstraint!
    @IBOutlet weak var buttonConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var messageField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBAction func sendButton(sender: UIButton) {
        let newMessage = Message(text: messageField.text!, user: messageField.text!)
        fb.sendMessage(newMessage)
        messageField.text! = ""
        self.tableView.reloadData()
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    func keyboardWillShow(notification: NSNotification) {
        var info = notification.userInfo!
        let keyboardFrame: CGRect = (info[UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue()
        self.textContraint = self.bottomContraint.constant
        //self.prevButtonContraint = self.buttonConstraint.constant
        UIView.animateWithDuration(0.1, animations: { () -> Void in
            self.bottomContraint.constant = keyboardFrame.size.height + 20
            //self.buttonConstraint.constant = keyboardFrame.size.height + 20

        })
    }
    func keyboardWillHide(notification : NSNotification) {
        
        self.bottomContraint.constant = self.textContraint!
        //self.buttonConstraint.constant = self.prevButtonContraint!

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
        self.messageField.delegate = self;
        
        fb.shareMessages{
            (message) in
            self.messages.append(message)
            self.tableView.reloadData()
        }
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "tapDismissKeyboard")
        view.addGestureRecognizer(tap)

    }
    
    func tapDismissKeyboard() {
        view.endEditing(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    /*
    func configureTableView() {
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 160.0
    }*/
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //Message With Image
        if self.messages[indexPath.row].imageURL != ""{
            //print("Image")
            let cell = tableView.dequeueReusableCellWithIdentifier("imageCell", forIndexPath: indexPath) as! MediaTableViewCell
            //TEXT
            if let label = cell.shareLabel{
                label.text = self.messages[indexPath.row].text
            }
            //IMAGE
            let image = UIImage(named:"temp_label")
            cell.shareImage.image = image
            return cell
        }
        //Message W/O Image
        else{
            //print("No Image")
            let cell = tableView.dequeueReusableCellWithIdentifier("shareCell", forIndexPath: indexPath)
            if let label = cell.textLabel{
                label.text = self.messages[indexPath.row].text
            }
            return cell
        }
        
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
