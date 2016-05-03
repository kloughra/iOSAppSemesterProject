//
//  NewsViewController.swift
//  NDRugby
//
//  Created by Katie Loughran on 4/26/16.
//  Copyright © 2016 Katie Loughran. All rights reserved.
//


import UIKit

class NewsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let fb = FacebookService()
    let fb2 = FireBaseService()
    var username:String?
    var news:[Message] = []
    //For Authorized Users
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func doneButton(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    @IBAction func addNewsButton(sender: AnyObject) {
        shouldPerformSegueWithIdentifier("addSegue", sender: sender)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Facebook
        fb.getUserName(){
            (username) in
            self.username = username
        }
        //Firebase
        fb2.newsMessages{
            (message) in
            self.news.append(message)
            self.tableView.reloadData()
        }
    }
    
    //Override to check for Authentication
    override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject?) -> Bool {
        var authorized:Bool = false
        for name in self.appDelegate.authorized_users{
            if self.username == name{
                authorized = true
            }
        }
        if authorized == true{
            print("Allowed")
            
        }else{
            print("Not Allowed")
            let alert = UIAlertController(title: "Incorrect Credentials", message: "Sorry, you are not authorized to add new stories. Please go share in the Share & Comment feed!", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
        return authorized
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        print(news.count)
        tableView.reloadData()
    }
    
    // MARK: - Table view data source
    
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
     // #warning Incomplete implementation, return the number of sections
        return 1
     }
     
     func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news.count
     }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if (self.news[indexPath.row].image) != nil{
            let cell = tableView.dequeueReusableCellWithIdentifier("mediaCell", forIndexPath: indexPath) as! MediaNewsTableViewCell
            //TEXT
            if let label = cell.updateText{
                label.text = self.news[indexPath.row].text
            }
            //IMAGE
            let image = news[indexPath.row].image
            cell.updateImage.image = image
            return cell
        }
            //Message W/O Image
        else{
            let cell = tableView.dequeueReusableCellWithIdentifier("normalCell", forIndexPath: indexPath) as! TextNewsTableViewCell
            if let label = cell.updateText{
                label.text = self.news[indexPath.row].text
            }
            return cell
        }

     }
    
    
    
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "addSegue" {
            if let consoleDetailViewController = segue.destinationViewController as? AddNewsViewController{
                consoleDetailViewController.onDataAvailable = {[weak self]
                    (message) in
                    if let _ = self {
                        self!.fb2.sendNewsMessage(message)
                        self!.tableView.reloadData()
                    }
                }
                    consoleDetailViewController.username = self.username
                
            }
        }
     }
 
    
}