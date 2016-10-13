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
import SwiftyJSON
//import WindowsAzureMessaging
public class KiboSDK{
    
    
    var delegateChatDetails1:UpdateChatDetailsDelegate!
  //  var kiboAppID=""
   // var kiboAppSecret=""
   // var kiboClientID=""
   // var sqliteDB:DatabaseHandler
    /*var  headers =  [
        "kibo-app-id" : "5wdqvvi8jyvfhxrxmu73dxun9za8x5u6n59",
        "kibo-app-secret": "jcmhec567tllydwhhy2z692l79j8bkxmaa98do1bjer16cdu5h79xvx",
        "kibo-client-id": "cd89f71715f2014725163952",
        
    ]*/
    
    
    /*static let sharedInstance = KiboSDK()
    class func getInstance() -> DatabaseObjectInitialiser
    {
        return sharedInstance
        
    }
    */
    public init (appID:String,appSecret:String,clientID:String,customerid:String,customerName:String!,companyemail:String!,phone:String!,account_number:String!){
        print("Kibo Engage SDK has been initialised version \(KiboEngageSDKVersionNumber)")
        
     //   var aaa:SBNotificationHub!
       
        DatabaseObjectInitialiser.getDB()
        
        /*if(DatabaseObjectInitialiser.getInstance().socketObj == nil)
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
        }*/
        
        
        //self.kiboAppID=appID
        //self.kiboAppSecret=appSecret
        //self.kiboClientID=clientID
       // DatabaseObjectInitialiser.getInstance().database.storeCredentials(appID, appSecret: appSecret, appClientID: clientID)
      /*  let next = self.storyboard?.instantiateViewControllerWithIdentifier("MainV2") as! GroupsViewController
        
        self.presentViewController(next, animated: true, completion: {
       */
        DatabaseObjectInitialiser.getInstance().database.storeCredentials(appID,appSecret:appSecret,appClientID:clientID,customerID:customerid)
        DatabaseObjectInitialiser.getInstance().appid=appID
        DatabaseObjectInitialiser.getInstance().secretid=appSecret
        DatabaseObjectInitialiser.getInstance().clientid=clientID
        DatabaseObjectInitialiser.getInstance().customerid=customerid
        /*  'name' : name.value //optional : remove key if not available,
        'email' : email.value //optional,
        'country' : country.value //optional,
        'phone' :   phone.value //optional,
        'companyid' : companyid,
        'isMobileClient':"false"}
    */
       // DatabaseObjectInitialiser.getInstance().optionalDataList["companyid"]=clientID
        
        if(customerName != nil && customerName != "")
        {
            print("customerName received is \(customerName)")
        DatabaseObjectInitialiser.getInstance().optionalDataList["customerName"]=customerName
        }
        if(companyemail != nil && companyemail != "")
        {
            print("companyemail received is \(companyemail)")
        DatabaseObjectInitialiser.getInstance().optionalDataList["email"]=companyemail
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
        
       // print("uniqueid is \(userInfo["uniqueid"])")
       // print("request_id is \(userInfo["request_id"])")
        // print("data is \(userInfo["data"])")
        if  let data = userInfo["data"]{
          //  print("inside 1")
            
            if  let agentid = userInfo["data"]!["agentid"] as? [String]{
                //got agents info, save in database
                var arrayOfAgentsIDs=userInfo["data"]!["agentid"] as! [String]
                var arrayOfAgentsEmails=userInfo["data"]!["agentemail"] as! [String]
                var arrayOfAgentsNames=userInfo["data"]!["agentname"] as! [String]
                var requestID=userInfo["data"]!["request_id"] as? String
                
                
                //Converting to Strings
                var stringOfAgentsIDs=arrayOfAgentsIDs.joinWithSeparator(",")
                var stringOfAgentsEmails=arrayOfAgentsEmails.joinWithSeparator(",")
                var stringOfAgentsNames=arrayOfAgentsNames.joinWithSeparator(",")
                
                /*
                 var stringarray:[String]=["aaa","bbb","ccc"]
                 //Array to string
                 var b=stringarray.joinWithSeparator(",")
                 //String to array
                 b.componentsSeparatedByString(",")
                 */
              //  print("... \(agentid)")
                //print("agents array \(arrayOfAgents)")
                print("save agents info in database")
                DatabaseObjectInitialiser.getDB().storeAgentsInfo(stringOfAgentsEmails,agent_id1:stringOfAgentsIDs,agent_name1:stringOfAgentsNames,request_id1:requestID!)
            }
            else
            {
        if  let singleuniqueid = userInfo["data"]!["uniqueid"] as? String {
            print("inside 2 unique id is \(singleuniqueid)")
            if  let requestid = userInfo["data"]!["request_id"] as? String {
                print("inside 3 requestid is \(requestid)")
                
                
                let seconds = 4.0
                let delay = seconds * Double(NSEC_PER_SEC)  // nanoseconds per seconds
                let dispatchTime = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
                
                dispatch_after(dispatchTime, dispatch_get_main_queue(), {
                    
                    // here code perfomed with delay
                    self.fetchSingleMessage(singleuniqueid,request_id: requestid)
                    
                })
                
                
               ///// fetchSingleMessage(singleuniqueid,request_id: requestid)
            }
        }
        }
        }
        else{
            print("error: wrong payload received")
        }
    }
    
    private func fetchSingleMessage(uniqueid:String, request_id:String)
        
        //uniqueid = h5ha3rgh4tag52eyn45cdi2016101025546;)
    {
        print("inside API call function uniqueid is \(uniqueid) request_id is \(request_id)")
    var url=Constants.mainURL+Constants.fetchSingleChat
    //print(url.debugDescription)
    /*
     'kibo-app-id' : '5wdqvvi8jyvfhxrxmu73dxun9za8x5u6n59',
     'kibo-app-secret': 'jcmhec567tllydwhhy2z692l79j8bkxmaa98do1bjer16cdu5h79xvx',
     'kibo-client-id': 'cd89f71715f2014725163952',
     */
    var header:[String:String]=["kibo-app-id":DatabaseObjectInitialiser.getInstance().appid,"kibo-app-secret":DatabaseObjectInitialiser.getInstance().secretid,"kibo-client-id":DatabaseObjectInitialiser.getInstance().clientid]
    ///var hhh=["headers":"\(header)"]
    print("headers are \(header.description)")
        Alamofire.request(.POST,"\(url)",parameters:["uniqueid":uniqueid,"request_id":request_id],headers:header).validate().responseJSON { response in
    
    /* print(response)
     print(".......")
     print(response.data!)
     print(".......")
     print(response.result.value!)*/
    
    /*
     
     "__v" = 0;
     "_id" = 57c69e61dfff9e5223a8fcb2;
     activeStatus = Yes;
     companyid = cd89f71715f2014725163952;
     createdby = 554896ca78aed92f4e6db296;
     creationdate = "2016-08-31T09:07:45.236Z";
     groupid = 57c69e61dfff9e5223a8fcb1;
     "msg_channel_description" = "This channel is for general discussions";
     "msg_channel_name" = General;
     
     
     */
            print("fetching single chat message")
            if(response.response?.statusCode == 200)
            {
                print(response.debugDescription)
                print(response.data!)
                print(response.result.value!)
                print(";;;;;;;;;;;;")
                var chatmsg2=JSON(response.result.value!)
                var chatmsg=JSON(response.data!)
                print("chat message fetched is \(chatmsg)")
                
                print("chat message2 fetched is \(chatmsg2)")
                /*
                 "datetime" : "2016-10-10T11:43:00.767Z",
                 "agentid" : [
                 
                 ],
                 "request_id" : "h d5771PZ 2016 10 4 9 43 1",
                 "agentemail" : [
                 
                 ],
                 "from" : "Jawaid",
                 "visitoremail" : "newemail@cloudkibo.com",
                 "type" : "message",
                 "messagechannel" : "574db78d23785bca7c650a0f",
                 "uniqueid" : "hwf6js2016101016430",
                 "is_seen" : "no",
                 "_id" : "57fb7ec57c3fbeaf73290b34",
                 "__v" : 0,
                 "msg" : "test message from agent",
                 "companyid" : "cd89f71715f2014725163952",
                 "to" : "newCustomer1"
                 */
                
                var agentid=""
                var agentemail=""
               // print(chatmsg2[0]["to"].string!)
              //  print(chatmsg2[0]["from"].string!)
                
               // print(chatmsg2[0]["type"].string!)
                //print(chatmsg2["from"].string!)
              //  if()
               DatabaseObjectInitialiser.getDB().storeChat(chatmsg2[0]["to"].string!, from1: chatmsg2[0]["from"].string!, visitoremail1: chatmsg2[0]["visitoremail"].string!, type1: chatmsg2[0]["type"].string!, uniqueid1: chatmsg2[0]["uniqueid"].string!, msg1: chatmsg2[0]["msg"].string!, datetime1: chatmsg2[0]["datetime"].string!, request_id1: chatmsg2[0]["request_id"].string!, messagechannel1: chatmsg2[0]["messagechannel"].string!, companyid1: chatmsg2[0]["companyid"].string!, is_seen1: chatmsg2[0]["is_seen"].string!, time1: chatmsg2[0]["datetime"].string!, fromMobile1: "no")
                
               //UPDATE UI
                Delegates.getInstance().UpdateChatDetailsDelegateCall()
              /*  if(delegateChatDetails1 ! nil)
                {
                    delegateChatDetails1?.refreshChatsUI("updateUI", data: nil)
                }*/
                
            }
            else{
                print("error in fetching chat")
            }
    
    }
    }
    
}



