//
//  RosterTableViewController.swift
//  NDRugby
//
//  Created by Katie Loughran on 4/11/16.
//  Copyright © 2016 Katie Loughran. All rights reserved.
//

import UIKit

class RosterTableViewController: UITableViewController {
    var roster:[Player] = []
    var photos:[PlayerPhoto] = []
    var borPhotos:[PlayerPhoto] = []
    var imageCache = [String:UIImage]()
    var borImageCache = [String:UIImage]()
    var username:String?
    
    let fb = FacebookService()
    let fb2 = FireBaseService()
    
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate


    @IBAction func backButton(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBOutlet weak var navOutlet: UINavigationItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fb2.getRoster(){
            (player) in
                self.roster.append(player)
                self.tableView.reloadData()
        }
        
        fb.images(){
            (photos) in
            self.photos = photos
        }
        
        fb.getBecauseOfRugby(self.roster){
            (photos) in
            self.borPhotos = photos
            self.tableView.reloadData()
        }
        
        fb.getUserName(){
            (username) in
            self.username = username
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return roster.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("playerCell", forIndexPath: indexPath) as! RosterTableViewCell
        let name = "\(self.roster[indexPath.row].firstName) \(self.roster[indexPath.row].lastName)"
        cell.playerName.text = name
        
        cell.hometown.text = self.roster[indexPath.row].hometown
            
        for photo in self.borPhotos{
            if let tags = photo.tags{
                for tag in tags{
                    if tag.lowercaseString.rangeOfString(name.lowercaseString) != nil {
                        //Check if Image is already cached
                        if let image = borImageCache[photo.source] {
                            let croppedImage: UIImage = ImageUtil.cropToSquare(image: image)
                            cell.playerPhoto.image = croppedImage
                            //print("photo already here! \(self.roster[indexPath.row].firstName)")
                        }else{
                            //print("had to fetch photo \(self.roster[indexPath.row].firstName)")
                            let im = fb.sourceImage(photo.source)
                            let croppedImage: UIImage = ImageUtil.cropToSquare(image: im!)
                            cell.playerPhoto.image = croppedImage
                            self.borImageCache[photo.source] = im
                                
                        }
                    }
                }
            }
        }
        

        return cell
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "playerDetailSegue" {
            if let playerDetailViewController = segue.destinationViewController as? PlayerDetailViewController,
                cell = sender as? RosterTableViewCell,
                indexPath = self.tableView.indexPathForCell(cell){
                //Pass console details
                var new_images:[UIImage] = []
                var new_photos:[PlayerPhoto] = []
                let name = "\(roster[indexPath.row].firstName) \(roster[indexPath.row].lastName)"
                for photo in self.photos{
                    if let tags = photo.tags{
                        for tag in tags{
                            if tag.lowercaseString.rangeOfString(name.lowercaseString) != nil {
                                if let image = imageCache[photo.source] {
                                    new_images.append(image)
                                }else{
                                    let im = fb.sourceImage(photo.source)
                                    new_images.append(im!)
                                    self.imageCache[photo.source] = im
                                    
                                }
                                new_photos.append(photo)
                            }
                        }
                    }
                }
                for photo in self.borPhotos{
                    if let tags = photo.tags{
                        for tag in tags{
                            if tag.lowercaseString.rangeOfString(name.lowercaseString) != nil {
                                playerDetailViewController.mainPhoto = photo
                            }
                        }
                    }
                }
                playerDetailViewController.player = self.roster[indexPath.row]
                
                playerDetailViewController.images = new_images
                playerDetailViewController.photos = new_photos
                
            }
        }else if segue.identifier == "addPlayer"{
            shouldPerformSegueWithIdentifier("addPlayer", sender: sender)
            if let addPlayerViewController = segue.destinationViewController as? AddPlayerViewController{
                print("Segue")
                addPlayerViewController.onDataAvailable = {[weak self]
                    (player) in
                    if let _ = self {
                        //self!.roster.append(player)
                        self!.fb2.addPlayerToRoster(player)
                        self!.tableView.reloadData()
                    }
                }
            }
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
        if authorized != true{
            let alert = UIAlertController(title: "Incorrect Credentials", message: "Sorry, you are not authorized to add new players.", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
        return authorized
    }
    
    

}
