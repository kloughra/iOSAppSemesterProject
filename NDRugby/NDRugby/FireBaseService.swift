//
//  FireBaseService.swift
//  NDRugby
//
//  Created by Katie Loughran on 4/5/16.
//  Copyright © 2016 Katie Loughran. All rights reserved.
//

import Foundation
import Firebase
import UIKit

class FireBaseService{
    var myRef = Firebase(url:"https://ndwomensrugby.firebaseio.com")
    
    
    func shareMessages(closure: (message:Message) -> Void){
        var mesgs:[Message] = []
        let shareRef = myRef.childByAppendingPath("ShareTable/Messages")
            shareRef.observeEventType(.ChildAdded, withBlock: { message in
                let text:String = message.value.objectForKey("text") as! String
                let user:String = message.key as String
                var imageURL:UIImage?;
                if let image = message.value.objectForKey("photoBase64"){
                    let base64String = image as! String
                    let options = NSDataBase64DecodingOptions.IgnoreUnknownCharacters
                    if let data = NSData(base64EncodedString: base64String, options: options){
                        imageURL = UIImage(data:data,scale:1.0)
                    }
                    
                }
                
                let newMessage = Message(text:text,user:user)
                if let image = imageURL{
                    newMessage.image = image;
                }
                closure(message:newMessage)
                mesgs.append(newMessage);
                }, withCancelBlock: { error in
                    print(error.description)
        })
    }

    func sendMessage(message:Message) -> Void{
        let shareRef = myRef.childByAppendingPath("ShareTable/Messages")
        if let image = message.image{
            let data:NSData = UIImageJPEGRepresentation(image, 0.1)!
            let base64String = data.base64EncodedStringWithOptions(NSDataBase64EncodingOptions.Encoding64CharacterLineLength)
            
            let jsonMessage = ["text":"\(message.text)","photoBase64":base64String]
            shareRef.updateChildValues(["\(message.user)":jsonMessage])
        }else{
            let jsonMessage = ["text":"\(message.text)"]
            shareRef.updateChildValues(["\(message.user)":jsonMessage])
        }
        
    }
    
}