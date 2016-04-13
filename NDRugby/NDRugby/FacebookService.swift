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
    
    init(){
        
        //let graphRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "673683302689201", parameters:["fields": "name"])

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
        //if (fid != "") {
            let id = 673683302689201
            let imgURLString = "https://graph.facebook.com/\(id)/picture?type=large" //type=normal
            let imgURL = NSURL(string: imgURLString)
            let imageData = NSData(contentsOfURL: imgURL!)
            let image = UIImage(data: imageData!)
        if let im = image{
            print("Got Image")
            return image
        }
            return nil
    }
    func getName(){
        //if (fid != "") {
        let id = 673683302689201
        let access_token = "CAACEdEose0cBAPR0ImrWkyAKoVoTKUGCZBk172WoYwTAz6LnCzZA682pfMc5OQGRTROyEun9F1Nhob9PK39ZCPfjPX6FgacAra8k6sJpy2ZAxaDAHD3dPVgYeEiQN0saJHjDL9bPPFT2g4oQ86W59Eylldvd0JsmRVZA8lBtBUPHCU820hUllwIIWkayvJUSE7RrJkSETSeOQKZCZCYItm8"
        
        let nameURLString = "https://graph.facebook.com/\(id)/albums?fields=name&access_token=\(access_token)" //type=normal
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
                            print("\(album["name"])")
                            album_ids.append(album["id"].stringValue)
                        }
                        
                    }
                    self.get_album_photos(album_ids)
                })
                
            }
        }
        task.resume()
    }
    
    
    func get_album_photos(album_ids:[String]){
        for id in album_ids{
            let access_token = "CAACEdEose0cBAPR0ImrWkyAKoVoTKUGCZBk172WoYwTAz6LnCzZA682pfMc5OQGRTROyEun9F1Nhob9PK39ZCPfjPX6FgacAra8k6sJpy2ZAxaDAHD3dPVgYeEiQN0saJHjDL9bPPFT2g4oQ86W59Eylldvd0JsmRVZA8lBtBUPHCU820hUllwIIWkayvJUSE7RrJkSETSeOQKZCZCYItm8"
            
            let nameURLString = "https://graph.facebook.com/\(id)?fields=photos&access_token=\(access_token)" //type=normal
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
                        let json = JSON(data: data!)
                        //print(json)
                        for(_,photo) in json["photos"]["data"]{
                            //add photo to an dictionary of photos and their tags
                            print("\(photo["id"]):")
                            for (_,tag) in photo["tags"]["data"]{
                                print("    \(tag["name"].stringValue)")
                            }
                            
                        }
                    })
                    
                }
            }
            task.resume()
            
        }
        
    }
}












