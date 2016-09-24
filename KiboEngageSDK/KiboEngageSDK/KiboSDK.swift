//
//  KiboSDK.swift
//  KiboEngageSDK
//
//  Created by Cloudkibo on 04/09/2016.
//  Copyright © 2016 KiboEngage. All rights reserved.
//

import Foundation
//import Alamofire
import SQLite
import UIKit
//import WindowsAzureMessaging
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
    
    public init (appID:String,appSecret:String,clientID:String,customerid:String,companyname:String!,companyemail:String!,phone:String!,account_number:String!){
        print("Kibo Engage SDK has been initialised")
        
     //   var aaa:SBNotificationHub!
        DatabaseObjectInitialiser.getDB()
        
        if(DatabaseObjectInitialiser.getInstance().socketObj == nil)
        {
            print("socket is nillll", terminator: "")
            //dispatch_async(dispatch_get_main_queue())
            //{
            DatabaseObjectInitialiser.getInstance().socketObj=SocketService(url:"\(Constants.socketurl)")
            ///socketObj.connect()
            //            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND,0))
            //{
            DatabaseObjectInitialiser.getInstance().socketObj.addHandlers()
            //socketObj.addWebRTCHandlers()
            //}
            //}
        }
        
        
        //self.kiboAppID=appID
        //self.kiboAppSecret=appSecret
        //self.kiboClientID=clientID
       // DatabaseObjectInitialiser.getInstance().database.storeCredentials(appID, appSecret: appSecret, appClientID: clientID)
      /*  let next = self.storyboard?.instantiateViewControllerWithIdentifier("MainV2") as! GroupsViewController
        
        self.presentViewController(next, animated: true, completion: {
       */
        DatabaseObjectInitialiser.getInstance().database.storeCredentials(appID, appSecret: appSecret, appClientID: clientID, companyname: "test company", companyemail: "")
        DatabaseObjectInitialiser.getInstance().appid=appID
        DatabaseObjectInitialiser.getInstance().secretid=appSecret
        DatabaseObjectInitialiser.getInstance().clientid=clientID
        DatabaseObjectInitialiser.getInstance().customerid=customerid
        if(companyname != nil && companyname != "")
        {
            print("comapnyname received is \(companyname)")
        DatabaseObjectInitialiser.getInstance().optionalDataList["companyname"]=companyname
        }
        if(companyemail != nil && companyemail != "")
        {
            print("companyemail received is \(companyemail)")
        DatabaseObjectInitialiser.getInstance().optionalDataList["companyemail"]=companyemail
        }
        if(phone != nil && phone != "")
        {
            print("phone received is \(phone)")
            DatabaseObjectInitialiser.getInstance().optionalDataList["phone"]=phone
        }
        if(account_number != nil && account_number != "")
        {
            print("account_number received is \(account_number)")
        DatabaseObjectInitialiser.getInstance().optionalDataList["account_number"]=account_number
        }
        
        print("optionalDataList data is \(DatabaseObjectInitialiser.getInstance().optionalDataList.debugDescription)")
        print(appID+" "+appSecret+" "+clientID)
        
        
        ////sqliteDB=DatabaseHandler(dbName:"kiboEngageDB.sqlite3")
        
      //////  let notificationTypes: UIUserNotificationType = [UIUserNotificationType.Alert, UIUserNotificationType.Badge, UIUserNotificationType.Sound]
        
        //let notificationTypes: UIUserNotificationType = [UIUserNotificationType.None]
        
        
       ////// let pushNotificationSettings = UIUserNotificationSettings(forTypes: notificationTypes, categories: nil)
        
        
        
        /////-------will be commented----
        //application.registerUserNotificationSettings(pushNotificationSettings)
        //application.registerForRemoteNotifications()
        
        
        //^^^^^^^^^^^^^^^^^^^
        
        //  print("username is \(username!)")
        //if(username != nil && username != "")
        //{
           ////// UIApplication.sharedApplication().registerUserNotificationSettings(pushNotificationSettings)
        //}
        
        

        
    }
    
  /*
    func application(application: UIApplication, didRegisterUserNotificationSettings notificationSettings: UIUserNotificationSettings) {
        print("didRegisterUserNotificationSettings")
        //if(!UIApplication.sharedApplication().isRegisteredForRemoteNotifications())
        // {
       // if(username != nil && username != "")
       // {
            print("didRegisterUserNotificationSettings... inside...")
            
            UIApplication.sharedApplication().registerForRemoteNotifications()
        //}
        
        // }
        
    }*/
    
   /* func application(application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData) {
        print("trying to register device token")
       // if(username != nil && username != ""){
            print("inside didRegisterForRemoteNotificationsWithDeviceToken ")
            var hub=SBNotificationHub(connectionString: Constants.connectionstring, notificationHubPath: Constants.hubname) //from constants file
            var tagarray=[String]()
            tagarray.append("+923201211991")
          //  print(username!.substringFromIndex(username!.startIndex.successor()))
            // var tagname=NSSet(object: username!.substringFromIndex(username!.startIndex))
            var tagname=NSSet(array: tagarray)
            // hub.registerNativeWithDeviceToken(deviceToken, tags: tagname as Set<NSObject>) { (error) in
            hub.registerNativeWithDeviceToken(deviceToken, tags: tagname as Set<NSObject>) { (error) in
                //hub.registerNativeWithDeviceToken(deviceToken, tags: nil) { (error) in
                
                if(error != nil)
                {
                    print("Registering for notifications \(error)")
                }
                else
                {
                    print("Successfully registered for notifications")
                    
                }
                
           // }
        }
    }*/
    
    
    /*
     received while the app is active:
     
     Copy
     - (void)application:(UIApplication *)application didReceiveRemoteNotification: (NSDictionary *)userInfo {
     NSLog(@"%@", userInfo);
     [self MessageBox:@"Notification" message:[[userInfo objectForKey:@"aps"] valueForKey:@"alert"]];
     }
     */
    
    
    
   /* func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject], fetchCompletionHandler completionHandler: (UIBackgroundFetchResult) -> Void) {
        // NSLog("received remote notification \(userInfo)")
        /*if(socketObj != nil)
        {
            socketObj.socket.emit("logClient","\(username) didReceiveRemoteNotification: \(userInfo.description)")
        }*/
        print("remote notification received is \(userInfo)")
        /*var notificationJSON=JSON(userInfo)
         print("json converted is \(notificationJSON)")
         print("json received is is \(notificationJSON["aps"])")
         */
        completionHandler(UIBackgroundFetchResult.NewData)
        NSNotificationCenter.defaultCenter().postNotificationName("ReceivedNotification", object:userInfo)
        /*
         json converted is {
         "aps" : {
         "data" : {
         "msg" : "Hello +923201211991! You joined the room."
         }
         }
         }
         */
        
        
        /*
         var payload = {
         +          type : im.stanza.type,
         +          senderId : im.stanza.from,
         +          uniqueId : im.stanza.uniqueid
         +        };
         +
         +        sendPushNotification(im.stanza.to, payload);
         +      }
         */
        // print("json received is is \(notificationJSON["aps"])")
    }
    */
    
    /*
     func application(application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData) {
     let token=JSON(deviceToken)
     print("device tokennnnnnn...", terminator: "")
     socketObj.socket.emit("logClient","deviceToken: \(token)")
     print(token.debugDescription)
     
     print("registered for notification", terminator: "")
     }
     */
    
   /* func application(application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: NSError) {
        
        print("registered for notification error", terminator: "")
        NSLog("Error in registration. Error: \(error)")
    }
    */
    
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
    
    public func handleRemoteNotifications(userInfo:[NSObject : AnyObject],withController:UIViewController)
    {
        print("inside kibo app received notification \(userInfo)")
    }
    
}
