//
//  PlayerPhotoViewController.swift
//  NDRugby
//
//  Created by Katie Loughran on 4/20/16.
//  Copyright © 2016 Katie Loughran. All rights reserved.
//

import UIKit

class PlayerPhotoViewController: UIViewController, UIScrollViewDelegate {

   
    var photo:UIImage?
    

    @IBOutlet weak var photoView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        if let image = photo{
            self.photoView.image = image
            self.photoView.contentMode = .ScaleAspectFit
            //self.scrollView.minimumZoomScale = 1.0
            //self.scrollView.maximumZoomScale = 10.0
            
            
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
    
    @IBAction func zoomPinch(sender: AnyObject) {
        var vWidth = self.view.frame.width
        var vHeight = self.view.frame.height
        
        var scrollImg: UIScrollView = UIScrollView()
        scrollImg.delegate = self
        scrollImg.frame = CGRectMake(0, 0, vWidth, vHeight)
        scrollImg.backgroundColor = UIColor(red: 90, green: 90, blue: 90, alpha: 0.90)
        scrollImg.alwaysBounceVertical = false
        scrollImg.alwaysBounceHorizontal = false
        scrollImg.showsVerticalScrollIndicator = true
        scrollImg.flashScrollIndicators()
        
        scrollImg.minimumZoomScale = 1.0
        scrollImg.maximumZoomScale = 10.0
        
        self.view.addSubview(scrollImg)
        
        self.photoView!.layer.cornerRadius = 11.0
        self.photoView!.clipsToBounds = false
        scrollImg.addSubview(self.photoView!)
    }
    
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return self.photoView
    }


}
