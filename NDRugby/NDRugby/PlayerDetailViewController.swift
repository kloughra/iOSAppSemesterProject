//
//  PlayerDetailViewController.swift
//  NDRugby
//
//  Created by Katie Loughran on 4/19/16.
//  Copyright © 2016 Katie Loughran. All rights reserved.
//

import UIKit

class PlayerDetailViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIGestureRecognizerDelegate {

    let fb = FacebookService()
    
    var images:[UIImage] = []
    var photos:[PlayerPhoto] = []
    var player:Player?
    var mainPhoto:PlayerPhoto?
    
    @IBOutlet weak var playerPhoto: UIImageView!
    @IBOutlet weak var fbCollectionView: UICollectionView!
    @IBOutlet weak var hometown: UILabel!
    @IBOutlet weak var major: UILabel!
    @IBOutlet weak var year: UILabel!
    @IBOutlet weak var position: UILabel!


    override func viewDidLoad() {
        super.viewDidLoad()

        self.fbCollectionView.dataSource = self
        self.fbCollectionView.delegate = self
        
        if let play = self.player{
            self.hometown.text = play.hometown
            self.major.text = play.major
            self.year.text = play.year
            self.position.text = play.position
            self.title = "\(play.firstName) \(play.lastName)"
            
        }
        if let mainP = self.mainPhoto{
            let im = fb.sourceImage(mainP.source)
            self.playerPhoto.image = im
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    //Collection Data Source
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("photoCell", forIndexPath: indexPath) as! PhotoCollectionViewCell
        cell.fbImageView.image = images[indexPath.row]
        let imageTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(PlayerDetailViewController.imageTap(_:)));
        imageTapRecognizer.cancelsTouchesInView = false
        cell.fbImageView.tag = indexPath.row
        imageTapRecognizer.numberOfTapsRequired = 1
        imageTapRecognizer.delegate = self
        cell.fbImageView.userInteractionEnabled = true
        cell.fbImageView.addGestureRecognizer(imageTapRecognizer)

        return cell
    }
    
    func imageTap(sender:UITapGestureRecognizer!) {
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    //Collection Flow Layout
    func collectionView(collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                               sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        let fbPhoto =  images[indexPath.item]
        var size = fbPhoto.size
        size.width = size.width/3
        size.width += 50
        size.height = size.height/3
        size.height += 50
        return size
    }
    

    
    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showPhoto" {
            if let playerPhotoViewController = segue.destinationViewController as? PlayerPhotoViewController, cell = sender as? UICollectionViewCell,
                indexPath = self.fbCollectionView.indexPathForCell(cell){
                playerPhotoViewController.photo = images[indexPath.row]

            }
        }
    }
}














