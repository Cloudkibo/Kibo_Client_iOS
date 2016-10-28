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
import SystemConfiguration
import AVFoundation
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
        
 //ChatSessions.init().getChatSessions()
 
 /*var teamsList=Teams.init()
 teamsList.fetchTeams()
 var messgeChannelsList=MessageChannels.init()
 messgeChannelsList.fetchMessageChannels()
 */
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0)) {
            print("synccccc fetching teams in background...")
            var chatsessions=ChatSessions.init()
            var teamsList=Teams.init()
            teamsList.fetchTeams({ (result,error) in
                if(result==true)
                {
                print("synccccc teams donee")
                print("synccccc fetching message channels...")
                var messgeChannelsList=MessageChannels.init()
                messgeChannelsList.fetchMessageChannels({ (result,error) in
                    if(result==true)
                    {
                        print("synccccc channels donee")
                        print("synccccc fetching chat sessions now...")
                        
                        chatsessions.getChatSessions({ (result, error) in
                            
                            if(result==true)
                            {
                                print("synccccc chat sessions fetched now..")
                                
                                var syncChatserviceObj=syncChatService.init()
                                syncChatserviceObj.syncChatFullRefresh({ (result, error) in
                                    
                                    if(result==true)
                                    {
                                        //syncBulkSMSfullRefresh
                                        var syncBulkSMSServiceObj=syncBulkSMSservice.init()
                                        syncBulkSMSServiceObj.syncBulkSMSfullRefresh({ (result, error) in
                                            
                                            if(result==true){
                                                 print("synccccc bulk SMS fetched now..")
                                            }
                                            print("synccccc updating UI now..")
                                            
                                            
                                            //update UI
                                            Delegates.getInstance().UpdateChatDetailsDelegateCall()
                                            })
                                        
                                        //get bulk sms
                                        //getAllBulkSMSListURL
                                        //post request
                                       
                                    }
                                    else
                                    {
                                        print("error: \(error)")
                                    }
                                })
                                
                            }
                            
                        })
                    }
                })
            }
                else
                {
                    print("error: \(error)")
                }
            })
        
        }
        
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
        
        let systemSoundID: SystemSoundID = 1016
        
        // to play sound
        AudioServicesPlaySystemSound (systemSoundID)
        
        
        print("inside kibo app received notification \(userInfo)")
       // print("receivednotification method called")
       // print("app state application is \(UIApplication.sharedApplication().applicationState.rawValue)")
       ///// print("app state is \(appstate.rawValue)")
       // print("app state value background is \(UIApplicationState.Background.rawValue)")
      //  print("app state value inactive is \(UIApplicationState.Inactive.rawValue)")
     //   print("app state value active is \(UIApplicationState.Active.rawValue)")
        
       // print("uniqueid is \(userInfo["uniqueid"])")
       // print("request_id is \(userInfo["request_id"])")
        // print("data is \(userInfo["data"])")
        if  let data = userInfo["data"]{
          //  print("inside 1")
            print("inside data .. ")
            if  let agentid = userInfo["data"]!["agentid"] as? [String]{
                print("inside got agentid")
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
                if  let havestatus = userInfo["data"]!["status"] as? String{
                    print("inside got status")
                    var status=userInfo["data"]!["status"] as! String
                    if(status != "")
                    {
                        //got push for status update
                        
                        var uniqueid=userInfo["data"]!["uniqueid"] as? String
                        var request_id = userInfo["data"]!["request_id"] as? String
                        var status = userInfo["data"]!["status"] as? String
                        
                        print("push received uniqueid \(uniqueid!) , request_id is \(request_id!) , status is \(status!)")
                        
                        //update status in database
                        DatabaseObjectInitialiser.getDB().updateChatStatus(uniqueid!, requestid1: request_id!, status1: status!)
                        
                        
                    }
                
       /* if  let singleuniqueid = userInfo["data"]!["uniqueid"] as? String {
            print("inside 2 unique id is \(singleuniqueid)")
            if  let requestid = userInfo["data"]!["request_id"] as? String {
                print("inside 3 requestid is \(requestid)")
                
             
                /*
                let seconds = 4.0
                let delay = seconds * Double(NSEC_PER_SEC)  // nanoseconds per seconds
                let dispatchTime = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
                
                dispatch_after(dispatchTime, dispatch_get_main_queue(), {
                    
                    // here code perfomed with delay
                    self.fetchSingleMessage(singleuniqueid,request_id: requestid)
                    
                })
                */
                
                syncPartialChat(DatabaseObjectInitialiser.getInstance().clientid, customerid: DatabaseObjectInitialiser.getInstance().customerid)
               ///fetchSingleMessage(singleuniqueid,request_id: requestid)
            }
            */
        }
        else{
            
             if  let singleuniqueid = userInfo["data"]!["uniqueid"] as? String {
             print("inside 2 unique id is \(singleuniqueid)")
             if  let requestid = userInfo["data"]!["request_id"] as? String {
             print("inside 3 requestid is \(requestid)")
             
             
             /*
             let seconds = 4.0
             let delay = seconds * Double(NSEC_PER_SEC)  // nanoseconds per seconds
             let dispatchTime = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
             
             dispatch_after(dispatchTime, dispatch_get_main_queue(), {
             
             // here code perfomed with delay
             self.fetchSingleMessage(singleuniqueid,request_id: requestid)
             
             })
             */
             
             syncPartialChat(DatabaseObjectInitialiser.getInstance().clientid, customerid: DatabaseObjectInitialiser.getInstance().customerid)
             ///fetchSingleMessage(singleuniqueid,request_id: requestid)
             }
             }
 
            //
            else{
                
                ///
                /*if  let type = userInfo["data"]!["type"] as? String!{
                    
                    if(type == "bulksms")
                    {
                        var uniqueid=userInfo["data"]!["uniqueid"] as? String
                        fetchP
                    }*/
                if  let title = userInfo["data"]!["title"] as? String{
                    print("inside got title bulk sms")
                    
                     var uniqueid=userInfo["data"]!["uniqueid"] as? String
                    var title=userInfo["data"]!["title"] as? String
                    
                    //if app active
                    //fetch using uniqueid
                    
                  //  if(appstate.rawValue == UIApplicationState.Active.rawValue)
                   // {
                        let systemSoundID: SystemSoundID = 1334
                        
                        // to play sound
                        AudioServicesPlaySystemSound (systemSoundID)
                   
                        
                        //uncomment later
                        ///////fetchSingleBulkSMS(uniqueid!)
                  //  }
                    //else
                    //do partial sync
                    
                }
                else
                {
                    if  let sync = userInfo["data"]!["obj"] as? [String:AnyObject]{
                        print("inside got sync push")
                        /*
                         _id : String
                         msg_channel_name : String,
                         msg_channel_description : String,
                         companyid : String,
                         groupid : String,
                         createdby : {type: Schema.ObjectId, ref: 'Account'},
                         creationdate : { type: Date, default: Date.now },
                         activeStatus : { type: String, default: 'Yes' }
                         },
                         tablename : “Channels”,
                         operation : “EditChannel” or “DeleteChannel” or “CreateChannel”,

 
 */
                        var obj=userInfo["data"]!["obj"] as? [String:AnyObject]
                        var operation=userInfo["data"]!["operation"] as? String
                        if(operation == "CreateChannel")
                        {
                            var _id = obj!["_id"] as! String
                            var msg_channel_name = obj!["msg_channel_name"] as! String
                            var msg_channel_description = obj!["msg_channel_description"] as! String
                            var companyid = obj!["companyid"] as! String
                            var groupid = obj!["groupid"] as! String
                            var createdby = obj!["createdby"] as! String
                            var creationdate = obj!["creationdate"] as! String
                            var deletestatus = "No"

                            DatabaseObjectInitialiser.getDB().storeMessageChannel(_id, channelname: msg_channel_name, channelDesc: msg_channel_description, compID: companyid, groupID: groupid, creeateby: createdby, datecreation: creationdate, delStatus: deletestatus)
                            
                            //create sessions
                            self.createNewSession(groupid,channelid1: _id,completion: {(result,error) in
                            if(result==true)
                            {
                            print("session created successfully")
                            }
                            else{
                                print("error:session creation failed")
                                
                                }
                            })
                      
                            
                            /*self.messageChannels = Table("messageChannels")
                            
                            do{
                                try db.run(messageChannels
                            }
                            catch{
                                
                            }*/
                            
                        }
                        if(operation == "DeleteChannel")
                        {
                            var _id = obj!["_id"] as! String

                            DatabaseObjectInitialiser.getDB().deleteMessageChannel(_id)
                            DatabaseObjectInitialiser.getDB().deleteSession(_id)
                            DatabaseObjectInitialiser.getDB().deleteChat(_id)
                            
                        }
                        if(operation == "EditChannel")
                        {
                            var _id = obj!["_id"] as! String
                            var msg_channel_name = obj!["msg_channel_name"] as! String
                            var msg_channel_description = obj!["msg_channel_description"] as! String
                            var companyid = obj!["companyid"] as! String
                            var groupid = obj!["groupid"] as! String
                            //var createdby = obj!["createdby"] as! String
                          //  var creationdate = obj!["creationdate"] as! String
                           // var deletestatus = obj!["activeStatus"] as! String
                            
                            DatabaseObjectInitialiser.getDB().updateMessageChannels(_id, channelname: msg_channel_name, channelDesc: msg_channel_description)

                        }
                    }
                    else
                    {
                    print("no payload matched")
                    }
                }
                
            }
            
                }
        }
         
            
        }
        else{
            print("error: wrong payload received")
        }
    }
    
    func createNewSession(groupid1:String,channelid1:String,completion:(result:Bool,error:String!)->())
    {
        //generate unique req id and save
        DatabaseObjectInitialiser.getDB().storeRequestIDs(groupid1, msgchannelid:channelid1)
        
       
        //now create session API call
        var sessionInfoList=[[String:AnyObject]]()
        var requestIDnew=DatabaseObjectInitialiser.getDB().getSingleRequestIDs(groupid1,messagechannel_id: channelid1)
      
        print("generated request id new is \(requestIDnew)")
        sessionInfoList.append(["departmentid":groupid1,"messagechannel":channelid1,"request_id":requestIDnew])
        var chatsessions=ChatSessions.init()
        
        if(sessionInfoList.count>0)
        {
            print("sessionInfoList count is \(sessionInfoList.count)")
            chatsessions.createRequiredChatSessions(sessionInfoList, completion: { (result, error) in
                
                if(result==true)
                {
                    completion(result: true, error: nil)
                }
                else{
                    completion(result: false, error: error)
                }
            })
        }
        else{
            completion(result: true, error: nil)
        }

        
        

    }
    
    func fetchSingleBulkSMS(id:String)
    {
        print("inside API call fetch bulk sms uniqueid is \(id)")
        var url=Constants.mainURL+Constants.getBulkSMSurl
        //print(url.debugDescription)
        /*
         'kibo-app-id' : '5wdqvvi8jyvfhxrxmu73dxun9za8x5u6n59',
         'kibo-app-secret': 'jcmhec567tllydwhhy2z692l79j8bkxmaa98do1bjer16cdu5h79xvx',
         'kibo-client-id': 'cd89f71715f2014725163952',
         */
        var header:[String:String]=["kibo-app-id":DatabaseObjectInitialiser.getInstance().appid,"kibo-app-secret":DatabaseObjectInitialiser.getInstance().secretid,"kibo-client-id":DatabaseObjectInitialiser.getInstance().clientid]
        ///var hhh=["headers":"\(header)"]
        print("headers are \(header.description)")
        Alamofire.request(.POST,"\(url)",parameters:["id":id],headers:header).validate().responseJSON { response in
            
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
            print("fetching single bulk sms message")
            if(response.response?.statusCode == 200)
            {
                
               /* let systemSoundID: SystemSoundID = 1334
                
                // to play sound
                AudioServicesPlaySystemSound (systemSoundID)*/
                
               // print(response.debugDescription)
               // print(response.data!)
               // print(response.result.value!)
                print(";;;;;;;;;;;;")
                var bulksms2=JSON(response.result.value!)
                var bulksms=JSON(response.data!)
                print("bulk sms message fetched is \(bulksms)")
                
                print("bulk sms2 fetched is \(bulksms2)")
                                let dateFormatter = NSDateFormatter()
                dateFormatter.timeZone=NSTimeZone.localTimeZone()
                dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
                //  let datens2 = dateFormatter.dateFromString(date2.debugDescription)
                //2016-09-18T19:13:00.588Z
                let datens2 = dateFormatter.dateFromString(bulksms2[0]["datetime"].string!)
                
                var imgurl=""
                if(bulksms2[0]["image_url"] != nil)
                {
                    imgurl=bulksms2[0]["image_url"].string!
                }
                DatabaseObjectInitialiser.getDB().storeBulkSMS(bulksms2[0]["title"].string!, description1: bulksms2[0]["description"].string!, agent_id1: bulksms2[0]["agent_id"].string!, hasImage1: bulksms2[0]["hasImage"].string!, image_url1: imgurl, companyid1: bulksms2[0]["companyid"].string!, datetime1: datens2!)
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
                
                let systemSoundID: SystemSoundID = 1016
                
                // to play sound
                AudioServicesPlaySystemSound (systemSoundID)
                
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
                
                
                print("storing chat sent by agent \(chatmsg2[0]["msg"].string!)")
                var customername=""
                if((DatabaseObjectInitialiser.getInstance().optionalDataList["customerName"]) != nil)
                {
                    print("customerName field not nil it exists")
                    customername=DatabaseObjectInitialiser.getInstance().optionalDataList["customerName"] as! String
                    
                    
                }
                let dateFormatter = NSDateFormatter()
                dateFormatter.timeZone=NSTimeZone.localTimeZone()
                dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
                var dateFormatted=dateFormatter.dateFromString(chatmsg2[0]["datetime"].string!)
                
                DatabaseObjectInitialiser.getDB().storeChat(chatmsg2[0]["to"].string!, from1: chatmsg2[0]["from"].string!, visitoremail1: chatmsg2[0]["visitoremail"].string!, type1: chatmsg2[0]["type"].string!, uniqueid1: chatmsg2[0]["uniqueid"].string!, msg1: chatmsg2[0]["msg"].string!, datetime1: dateFormatted!, request_id1: chatmsg2[0]["request_id"].string!, messagechannel1: chatmsg2[0]["messagechannel"].string!, companyid1: chatmsg2[0]["companyid"].string!, is_seen1: chatmsg2[0]["is_seen"].string!, fromMobile1: "yes",status1:chatmsg2[0]["status"].string!,customername1: customername )
                
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
    
    
    private func syncPartialBulkSMS(companyid:String, customerid:String)
        
        //uniqueid = h5ha3rgh4tag52eyn45cdi2016101025546;)
    {
        print("inside syncPartialChat function syncPartialChat is \(syncPartialChat)")
        var url=Constants.mainURL+"fetchPartial"
        
        var header:[String:String]=["kibo-app-id":DatabaseObjectInitialiser.getInstance().appid,"kibo-app-secret":DatabaseObjectInitialiser.getInstance().secretid,"kibo-client-id":DatabaseObjectInitialiser.getInstance().clientid]
        ///var hhh=["headers":"\(header)"]
        print("headers are \(header.description)")
        Alamofire.request(.POST,"\(url)",parameters:["companyid":companyid,"customerid":customerid],headers:header).validate().responseJSON { response in
            
            print("partial bulk sms sync API called")
            if(response.response?.statusCode == 200)
            {
                
                let systemSoundID: SystemSoundID = 1016
                
                // to play sound
                AudioServicesPlaySystemSound (systemSoundID)
                
                
                print(";;;;;;;;;;;;")
                var bulksms2=JSON(response.result.value!)
                var bulksms=JSON(response.data!)
                print("bulksms message sync is \(bulksms)")
                
                print("bulksms message2 sync is \(bulksms2)")
                var agentid=""
                var agentemail=""
                
                var updateStatusArray=[[String:AnyObject]]()
                var i=0
                for(i=0;i<bulksms2.count;i++)
                {
                    let systemSoundID: SystemSoundID = 1334
                    
                    // to play sound
                    AudioServicesPlaySystemSound (systemSoundID)
                    
                                       let dateFormatter = NSDateFormatter()
                    dateFormatter.timeZone=NSTimeZone.localTimeZone()
                    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
                    //  let datens2 = dateFormatter.dateFromString(date2.debugDescription)
                    //2016-09-18T19:13:00.588Z
                    let datens2 = dateFormatter.dateFromString(bulksms2[i]["datetime"].string!)
                    
                    var imgurl=""
                    if(bulksms2[i]["image_url"] != nil)
                    {
                        imgurl=bulksms2[i]["image_url"].string!
                    }
                    DatabaseObjectInitialiser.getDB().storeBulkSMS(bulksms2[i]["title"].string!, description1: bulksms2[i]["description"].string!, agent_id1: bulksms2[i]["agent_id"].string!, hasImage1: bulksms2[i]["hasImage"].string!, image_url1: imgurl, companyid1: bulksms2[i]["companyid"].string!, datetime1: datens2!)
                }
                
                
                //UPDATE UI
                //uncomment to update bulk sms ui
               // Delegates.getInstance().UpdateChatDetailsDelegateCall()
                
                //call API for updateStatus to send status to server
                //uncomment later
                /*if(updateStatusArray.count>0)
                {
                    print("updateStatusArray count is \(updateStatusArray.count), calling API now")
                    self.updateStatus(updateStatusArray)
                }*/
                
            }
            else{
                print("error in bulk sms partial sync")
            }
            
        }
    }

    private func syncPartialChat(companyid:String, customerid:String)
        
        //uniqueid = h5ha3rgh4tag52eyn45cdi2016101025546;)
    {
        print("inside syncPartialChat function syncPartialChat is \(syncPartialChat)")
    var url=Constants.mainURL+Constants.partialSyncChat
   
    var header:[String:String]=["kibo-app-id":DatabaseObjectInitialiser.getInstance().appid,"kibo-app-secret":DatabaseObjectInitialiser.getInstance().secretid,"kibo-client-id":DatabaseObjectInitialiser.getInstance().clientid]
    ///var hhh=["headers":"\(header)"]
    print("headers are \(header.description)")
        Alamofire.request(.POST,"\(url)",parameters:["companyid":companyid,"customerid":customerid],headers:header).validate().responseJSON { response in
    
      print("partial chat sync API called")
            if(response.response?.statusCode == 200)
            {
                
                //uncomment later moving up for testing
            /*    let systemSoundID: SystemSoundID = 1016
                
                // to play sound
                AudioServicesPlaySystemSound (systemSoundID)
                
              */
                print(";;;;;;;;;;;;")
                var chatmsg2=JSON(response.result.value!)
                var chatmsg=JSON(response.data!)
              //  print("chat message sync is \(chatmsg)")
                
                print("chat message2 sync is \(chatmsg2)")
                               var agentid=""
                var agentemail=""
              
                 var updateStatusArray=[[String:AnyObject]]()
                var i=0
                for(i=0;i<chatmsg2.count;i++)
                {
                    var updateStatusData=[String:AnyObject]()
                    //add in status array to be sent in update Status API
                    updateStatusData["uniqueid"]=chatmsg2[i]["uniqueid"].string!
                    updateStatusData["request_id"]=chatmsg2[i]["request_id"].string!
                    updateStatusData["status"]="delivered"
                   
                    
                    
                    //do in server response
                    
                    //DatabaseObjectInitialiser.getDB().updateChatStatus(chatmsg2[i]["uniqueid"].string!, requestid1: chatmsg2[i]["request_id"].string!, status1: "delivered")
                    updateStatusArray.append(updateStatusData)
                    
                    
                    //storing chat in local database
                    print("storing chat sent by agent \(chatmsg2[i]["msg"].string!)")
                    var customername=""
                    if((DatabaseObjectInitialiser.getInstance().optionalDataList["customerName"]) != nil)
                    {
                        print("customerName field not nil it exists")
                        customername=DatabaseObjectInitialiser.getInstance().optionalDataList["customerName"] as! String
                        
                        
                    }
                    
                    let dateFormatter = NSDateFormatter()
                    dateFormatter.timeZone=NSTimeZone.localTimeZone()
                    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
                    //  let datens2 = dateFormatter.dateFromString(date2.debugDescription)
                    //2016-09-18T19:13:00.588Z
                    let datens2 = dateFormatter.dateFromString(chatmsg2[i]["datetime"].string!)
                    
                    
                    DatabaseObjectInitialiser.getDB().storeChat(chatmsg2[i]["to"].string!, from1: chatmsg2[i]["from"].string!, visitoremail1: chatmsg2[i]["visitoremail"].string!, type1: chatmsg2[i]["type"].string!, uniqueid1: chatmsg2[i]["uniqueid"].string!, msg1: chatmsg2[i]["msg"].string!, datetime1: datens2!, request_id1: chatmsg2[i]["request_id"].string!, messagechannel1: chatmsg2[i]["messagechannel"].string!, companyid1: chatmsg2[i]["companyid"].string!, is_seen1: chatmsg2[i]["is_seen"].string!, fromMobile1: "yes",status1:chatmsg2[i]["status"].string!,customername1: customername )
 
                }
                
                
               //UPDATE UI
                Delegates.getInstance().UpdateChatDetailsDelegateCall()
             
                //call API for updateStatus to send status to server
                if(updateStatusArray.count>0)
                {
                    print("updateStatusArray count is \(updateStatusArray.count), calling API now")
                self.updateStatus(updateStatusArray)
                }
                
                           }
            else{
                print("error in fetching chat")
            }
    
    }
    }
    
    func updateStatus(updateStatusData:[[String:AnyObject]])
    {
        
        print("inside updateStatus function updateStatusData is \(updateStatusData)")
        
        var url=Constants.mainURL+Constants.updateStatus
       
        var header:[String:String]=["kibo-app-id":DatabaseObjectInitialiser.getInstance().appid,"kibo-app-secret":DatabaseObjectInitialiser.getInstance().secretid,"kibo-client-id":DatabaseObjectInitialiser.getInstance().clientid]
        
        print("headers are \(header.description)")
        var messagesArray=[String:AnyObject]()
        messagesArray["messages"]=updateStatusData
        Alamofire.request(.POST,"\(url)",parameters:messagesArray,headers:header,encoding: .JSON).validate().responseJSON { response in
       
            
        //Alamofire.request(.POST,"\(url)",parameters:["messages":updateStatusData],headers:header).validate().responseJSON { response in
                        print("calling updateStatus API from kiboSDK \(messagesArray)")
            if(response.response?.statusCode == 200)
            {
                print("response is \(response.response?.debugDescription)")
                var statusjson=JSON(response.result.value!)
                print("statusUpdate API result json is \(statusjson["status"])")
                if(statusjson["status"].string == "statusUpdated")
                {
                    //update local database
                    for(var i=0;i<updateStatusData.count;i++)
                    {
                        DatabaseObjectInitialiser.getDB().updateChatStatus(updateStatusData[i]["uniqueid"] as! String, requestid1: updateStatusData[i]["request_id"] as! String, status1: updateStatusData[i]["status"] as! String)
                    }
                    
                    Delegates.getInstance().UpdateChatDetailsDelegateCall()
                 
                //got response
                //status update sent to server
                
            }
                else{
                    print("error is status update")
                }
            }
            else
            {
                print(response.debugDescription)
                print(response.response?.debugDescription)
                print("error: calling statusUpdate API failed")
            }
        
    }
    }
    
}



