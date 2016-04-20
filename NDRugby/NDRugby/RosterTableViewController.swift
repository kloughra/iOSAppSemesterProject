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
    let fb = FacebookService()

    override func viewDidLoad() {
        super.viewDidLoad()
        let newPlayer = Player(firstName: "Katie", lastName: "Loughran", hometown: "South Bend, IN", year: "Senior", position: "8", major:"Computer Science")
        roster.append(newPlayer)
        
        fb.images(){
            (photos) in
            self.photos = photos
            //print(self.photos)
            for photo in self.photos{
                print(photo.source)
            }
        }
        let im:UIImage = fb.getProfPic()!
        newPlayer.photo = im
        //fb.getName()
        
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
        print(name)
        cell.hometown.text = self.roster[indexPath.row].hometown
        if let image = self.roster[indexPath.row].photo{
            cell.playerPhoto.image = image
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
                                print("Photo with tag \(name)")
                                new_images.append(fb.sourceImage(photo.source)!)
                                new_photos.append(photo)
                            }
                        }
                    }
                }
                print(roster[indexPath.row].hometown)
                playerDetailViewController.player = self.roster[indexPath.row]
                
                playerDetailViewController.images = new_images
                playerDetailViewController.photos = new_photos
                
            }
        }
    }
    

}
