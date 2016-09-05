//
//  KiboSDK.swift
//  KiboEngageSDK
//
//  Created by Cloudkibo on 04/09/2016.
//  Copyright © 2016 KiboEngage. All rights reserved.
//

import Foundation
import Alamofire


public class KiboSDK{
    var kiboAppID=""
    var kiboAppSecret=""
    var kiboClientID=""
    /*var  headers =  [
        "kibo-app-id" : "5wdqvvi8jyvfhxrxmu73dxun9za8x5u6n59",
        "kibo-app-secret": "jcmhec567tllydwhhy2z692l79j8bkxmaa98do1bjer16cdu5h79xvx",
        "kibo-client-id": "cd89f71715f2014725163952",
        
    ]*/
    
    public init (appID:String,appSecret:String,clientID:String){
        print("Kibo Engage SDK has been initialised")
        self.kiboAppID=appID
        self.kiboAppSecret=appSecret
        self.kiboClientID=clientID
        
    }
    
    public func doSomething()
    {
        print("Yeah, it works. Welcome to Live Chat!")
        print(self.kiboAppID)
        print(self.kiboAppSecret)
        print(self.kiboClientID)
    
    }
}
