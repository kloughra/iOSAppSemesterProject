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
    let fb = FireBaseService();
    

    @IBOutlet weak var messageField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBAction func sendButton(sender: UIButton) {
        let newMessage = Message(text: messageField.text!, user: "user1")
        fb.sendMessage(newMessage)
        messageField.text! = ""
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.messageField.delegate = self;
        
        fb.shareMessages{
            (message) in
            self.messages.append(message)
            self.tableView.reloadData()
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("shareCell", forIndexPath: indexPath)
        if let label = cell.textLabel{
            label.text = self.messages[indexPath.row].text
        }
        return cell
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
