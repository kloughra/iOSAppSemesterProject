//
//  PlayerDetailViewController.swift
//  NDRugby
//
//  Created by Katie Loughran on 4/19/16.
//  Copyright © 2016 Katie Loughran. All rights reserved.
//

import UIKit

class PlayerDetailViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    var photos:[UIImage] = []
    
    @IBOutlet weak var fbCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let fb = FacebookService()
        let im:UIImage = fb.getProfPic()!
        photos.append(im)
        photos.append(im)
        photos.append(im)
        photos.append(im)
        photos.append(im)
        photos.append(im)
        photos.append(im)
        self.fbCollectionView.dataSource = self
        self.fbCollectionView.delegate = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //Collection Data Source
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("photoCell", forIndexPath: indexPath) as! PhotoCollectionViewCell
        //cell.backgroundColor = UIColor.blackColor()
        cell.fbImageView.image = photos[indexPath.row]
        // Configure the cell
        return cell
    }
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    //Collection Flow Layout
    func collectionView(collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                               sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        let fbPhoto =  UIImage()
        /*
        if var size = fbPhoto.thumbnail?.size {
            size.width += 10
            size.height += 10
            return size
        }*/
        return CGSize(width: 100, height: 100)
    }
    
   /* func collectionView(collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                               insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return self.sectionInsets
    }*/

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
