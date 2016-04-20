//
//  PlayerPhotoViewController.swift
//  NDRugby
//
//  Created by Katie Loughran on 4/20/16.
//  Copyright © 2016 Katie Loughran. All rights reserved.
//

import UIKit

class PlayerPhotoViewController: UIViewController {

    var photo:UIImage?
    
    @IBOutlet weak var photoView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        if let image = photo{
            self.photoView.image = image
            self.photoView.contentMode = .ScaleAspectFit
            /*var widthRatio = self.photoView.bounds.size.width / self.photoView.image!.size.width;
            var heightRatio  = self.photoView.bounds.size.height / self.photoView.image!.size.height;
            var scale  = min(widthRatio, heightRatio);
            //var imageWidth  = scale * self.photoView.image!.size.width;
            //var imageHeight  = scale * self.photoView.image!.size.height;
            var imageWidth  = self.photoView.image!.size.width * 0.5;
            var imageHeight  = self.photoView.image!.size.height * 0.5;
            //self.photoView.frame = CGRectMake(self.photoView.frame.origin.x, self.photoView.frame.origin.y,size.width, size.height)
            self.photoView.frame = CGRectMake(0, 0, imageWidth, imageHeight);
            self.photoView.center = self.photoView.superview!.center;*/
        }
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
