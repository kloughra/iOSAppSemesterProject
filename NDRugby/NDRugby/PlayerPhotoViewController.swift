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
        }
    }
    
    @IBAction func zoomPinch(sender: AnyObject) {
        let vWidth = self.view.frame.width
        let vHeight = self.view.frame.height
        let scrollImg: UIScrollView = UIScrollView()
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
