//
//  KiboSDK.swift
//  KiboEngageSDK
//
//  Created by Cloudkibo on 04/09/2016.
//  Copyright © 2016 KiboEngage. All rights reserved.
//

import Foundation
import Alamofire
import SQLite
import UIKit

public class KiboSDK{
    
  //  var kiboAppID=""
   // var kiboAppSecret=""
   // var kiboClientID=""
   // var sqliteDB:DatabaseHandler
    /*var  headers =  [
        "kibo-app-id" : "5wdqvvi8jyvfhxrxmu73dxun9za8x5u6n59",
        "kibo-app-secret": "jcmhec567tllydwhhy2z692l79j8bkxmaa98do1bjer16cdu5h79xvx",
        "kibo-client-id": "cd89f71715f2014725163952",
        
    ]*/
    
    public init (appID:String,appSecret:String,clientID:String){
        print("Kibo Engage SDK has been initialised")
        //self.kiboAppID=appID
        //self.kiboAppSecret=appSecret
        //self.kiboClientID=clientID
       // DatabaseObjectInitialiser.getInstance()
       // DatabaseObjectInitialiser.getInstance().database.storeCredentials(appID, appSecret: appSecret, appClientID: clientID)
      /*  let next = self.storyboard?.instantiateViewControllerWithIdentifier("MainV2") as! GroupsViewController
        
        self.presentViewController(next, animated: true, completion: {
       */
            
        print(appID+" "+appSecret+" "+clientID)
        
        
        ////sqliteDB=DatabaseHandler(dbName:"kiboEngageDB.sqlite3")
        
    }
    
    public func doSomething()
    {
        print("Yeah, it works. Welcome to Live Chat!")
       /* let kiboAppID = Expression<String>("kiboAppID")
        let kiboAppSecret = Expression<String>("kiboAppSecret")
        let kiboClientID = Expression<String>("kiboClientID")
        

        print(DatabaseObjectInitialiser.getInstance().database.credentials.select([kiboAppID,kiboAppSecret,kiboClientID]))
       // print(self.kiboAppSecret)
        //print(self.kiboClientID)
    */
    }
    
    
}
