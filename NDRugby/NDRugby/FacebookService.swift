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
}