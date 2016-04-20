//
//  FacebookService.swift
//  NDRugby
//
//  Created by Katie Loughran on 4/11/16.
//  Copyright © 2016 Katie Loughran. All rights reserved.
//

import Foundation
import FBSDKCoreKit
import FBSDKShareKit
import FBSDKLoginKit

class FacebookService{
    private var photos:[PlayerPhoto] = []
    //var group:dispatch_group_t = dispatch_group_create()
    
    init(){
    }
    
    func requestFacebook(closure: (logButton:FBSDKLoginButton) -> Void){
        let loginButton:FBSDKLoginButton = FBSDKLoginButton()
        closure(logButton: loginButton)
        /*
        let graphRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me", parameters: nil)
        graphRequest.startWithCompletionHandler({ (connection, result, error) -> Void in
            var x = 3
        })*/
    }
    
    func getProfPic() -> UIImage? {
        let id = 673683302689201
        let imgURLString = "https://graph.facebook.com/\(id)/picture?type=large" //type=normal
        let imgURL = NSURL(string: imgURLString)
        let imageData = NSData(contentsOfURL: imgURL!)
        let image = UIImage(data: imageData!)
        if let im = image{
            print("Got Image")
            return im
        }
            return nil
    }
    func sourceImage(sourceURL:String) -> UIImage? {
        if (sourceURL != "") {
            print(sourceURL)
            let imgURLString = sourceURL
            let imgURL = NSURL(string: imgURLString)
            let imageData = NSData(contentsOfURL: imgURL!)
            let image = UIImage(data: imageData!)
            if let im = image{
                return im
            }
        }
        return nil
    }
    func images(closure:(images:[PlayerPhoto]) -> Void){
        //if (fid != "") {
        let id = 673683302689201
        let access_token = FBSDKAccessToken.currentAccessToken()
        //print("\(access_token.tokenString)")
        
        let nameURLString = "https://graph.facebook.com/\(id)/albums?fields=name&access_token=\(access_token.tokenString)" //type=normal
        let nameURL = NSURL(string: nameURLString)
        let request = NSMutableURLRequest(URL: nameURL!)
    
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(request){
            (data, responseText, error) -> Void in
            if error != nil {
                print(error)
            } else {
                //var inf = [String]()
                var album_ids = [String]()
                dispatch_async(dispatch_get_main_queue(), {
                    let json = JSON(data: data!)
                    //print(json)
                    for(_,album) in json["data"]{
                        
                        if(album["name"].stringValue != "Cover Photos" && album["name"].stringValue != "Profile Pictures"){
                            //print("\(album["name"])")
                            album_ids.append(album["id"].stringValue)
                        }
                        
                    }
                    self.get_album_photos(album_ids){
                    //print(self.photos)
                        (im, count) in
                        if count >= album_ids.count{
                            closure(images: self.photos)
                        }
                    }
                })
                
            }
        }
        task.resume()
    }
    
    
    func get_album_photos(album_ids:[String], closure:(images:[PlayerPhoto], count:Int)-> Void){
        var cnt:Int = 0
        for id in album_ids{
            let access_token = FBSDKAccessToken.currentAccessToken()

            let nameURLString = "https://graph.facebook.com/\(id)?fields=photos%7Bimages,name,tags,source%7D&access_token=\(access_token.tokenString)" //type=normal
            let nameURL = NSURL(string: nameURLString)
            let request = NSMutableURLRequest(URL: nameURL!)
            let session = NSURLSession.sharedSession()
            let task = session.dataTaskWithRequest(request){
                (data, responseText, error) -> Void in
                if error != nil {
                    print(error)
                } else {
                    //var inf = [String]()
                    dispatch_async(dispatch_get_main_queue(), {
                        cnt = cnt + 1;
                        let json = JSON(data: data!)
                        //print(json)
                        for(_,photo) in json["photos"]["data"]{
                            //add photo to an dictionary of photos and their tags
                            var tags = [String]()
                            //print("\(photo["id"]):")
                            for (_,tag) in photo["tags"]["data"]{
                                tags.append(tag["name"].stringValue)
                                //print("    \(tag["name"].stringValue)")
                            }
                            let newPhoto = PlayerPhoto(id:photo["id"].stringValue,source:photo["source"].stringValue)
                            //Only add photos with tags
                            if tags.count > 0{
                                newPhoto.tags = tags
                                self.photos.append(newPhoto)
                            }
                            
                            
                        }
                        //print(cnt)
                        closure(images: self.photos, count: cnt)
                    })
                    
                }
                //print(self.photos)
            }
            task.resume()

        }
    }
    
}












