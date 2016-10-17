//
//  AppDelegate.swift
//  kiboLiveChat
//
//  Created by Cloudkibo on 08/09/2016.
//  Copyright © 2016 KiboEngage. All rights reserved.
//

import UIKit
import CoreData
import KiboEngageSDK
import Foundation
//import WindowsAzureMessaging

import SystemConfiguration
import AVFoundation
//iCloud.MyAppTemplates.cloudkibo
//com.kiboEngage.kiboLiveChat


var kiboLiveChat:KiboSDK!

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var aaa:SBNotificationHub!

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        
        
        let date = NSDate()
        
        // *** create calendar object ***
        var calendar = NSCalendar.currentCalendar()
        
        // *** Get components using current Local & Timezone ***
        print("datetime")
        print(calendar.components(NSCalendarUnit.Year,fromDate: date))
            //,NSCalendarUnit.Month,NSCalendarUnit.Day,NSCalendarUnit.Hour,NSCalendarUnit.Minute,NSCalendarUnit.Second]
        var year=calendar.components(NSCalendarUnit.Year,fromDate: date).year
        var month=calendar.components(NSCalendarUnit.Month,fromDate: date).month
        var day=calendar.components(.Day,fromDate: date).day
        var hr=calendar.components(NSCalendarUnit.Hour,fromDate: date).hour
        var min=calendar.components(NSCalendarUnit.Minute,fromDate: date).minute
        var sec=calendar.components(NSCalendarUnit.Second,fromDate: date).second
        print("\(year) \(month) \(day) \(hr) \(min) \(sec)")
    
        application.statusBarHidden = true
        kiboLiveChat=KiboSDK.init(appID:"5wdqvvi8jyvfhxrxmu73dxun9za8x5u6n59", appSecret: "jcmhec567tllydwhhy2z692l79j8bkxmaa98do1bjer16cdu5h79xvx", clientID: "cd89f71715f2014725163952",customerid: "newCustomer11", customerName: nil, companyemail: "newemail@cloudkibo.com", phone: "01234556774", account_number: nil)
        
        
        let notificationTypes: UIUserNotificationType = [UIUserNotificationType.Alert, UIUserNotificationType.Badge, UIUserNotificationType.Sound]
        
        //let notificationTypes: UIUserNotificationType = [UIUserNotificationType.None]
        
        
        let pushNotificationSettings = UIUserNotificationSettings(forTypes: notificationTypes, categories: nil)
        
        
        
        /////-------will be commented----
        //application.registerUserNotificationSettings(pushNotificationSettings)
        //application.registerForRemoteNotifications()
        
        
        //^^^^^^^^^^^^^^^^^^^
        
        //  print("username is \(username!)")
        //if(username != nil && username != "")
        //{
            UIApplication.sharedApplication().registerUserNotificationSettings(pushNotificationSettings)
        //}
        
        
        return true
    }

    func application(application: UIApplication, didRegisterUserNotificationSettings notificationSettings: UIUserNotificationSettings) {
        print("didRegisterUserNotificationSettings")
        //if(!UIApplication.sharedApplication().isRegisteredForRemoteNotifications())
        // {
       // if(username != nil && username != "")
       // {
            print("didRegisterUserNotificationSettings... inside...")
            
            UIApplication.sharedApplication().registerForRemoteNotifications()
       // }
        
        // }
        
    }
    
    
    func application(application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData) {
        print("trying to register device token")
      //  if(username != nil && username != ""){
            print("inside didRegisterForRemoteNotificationsWithDeviceToken")
            aaa=SBNotificationHub(connectionString: ConstantsString.connectionstring, notificationHubPath: ConstantsString.hubname) //from constants file
            var tagarray=[String]()
           ///// tagarray.append(username!.substringFromIndex(username!.startIndex.successor()))
           // print(username!.substringFromIndex(username!.startIndex.successor()))
            // var tagname=NSSet(object: username!.substringFromIndex(username!.startIndex))
            tagarray.append("newCustomer1")
            var tagname=NSSet(array: tagarray)
            // hub.registerNativeWithDeviceToken(deviceToken, tags: tagname as Set<NSObject>) { (error) in
        if(aaa != nil)
        {
            aaa.registerNativeWithDeviceToken(deviceToken, tags: tagname as! Set<NSObject>) { (error) in
                //hub.registerNativeWithDeviceToken(deviceToken, tags: nil) { (error) in
                
                if(error != nil)
                {
                    print("Registering for notifications \(error)")
                }
                else
                {
                    print("Successfully registered for notifications")
                    
                }
                
            }
    }
        
        
        //====
        /*
        var hub=SBNotificationHub(connectionString: "nn", notificationHubPath: ConstantsString.hubname) //from constants file
        var tagarray2=[String]()
        ///// tagarray.append(username!.substringFromIndex(username!.startIndex.successor()))
        // print(username!.substringFromIndex(username!.startIndex.successor()))
        // var tagname=NSSet(object: username!.substringFromIndex(username!.startIndex))
        tagarray2.append("sojharo")
        var tagname2=NSSet(array: tagarray2)
        // hub.registerNativeWithDeviceToken(deviceToken, tags: tagname as Set<NSObject>) { (error) in
        if(hub != nil)
        {
            hub.registerNativeWithDeviceToken(deviceToken, tags: tagname as! Set<NSObject>) { (error) in
                //hub.registerNativeWithDeviceToken(deviceToken, tags: nil) { (error) in
                
                if(error != nil)
                {
                    print("Registering for notifications \(error)")
                }
                else
                {
                    print("Successfully registered for notifications")
                    
                }
                
            }
        }*/

     //   }
    }
    
    
    /*
     received while the app is active:
     
     Copy
     - (void)application:(UIApplication *)application didReceiveRemoteNotification: (NSDictionary *)userInfo {
     NSLog(@"%@", userInfo);
     [self MessageBox:@"Notification" message:[[userInfo objectForKey:@"aps"] valueForKey:@"alert"]];
     }
     */
    
    
    
    func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject], fetchCompletionHandler completionHandler: (UIBackgroundFetchResult) -> Void) {
        
        print("receivednotification method called \(userInfo.description)")
       // let navigationController = UIApplication.sharedApplication().windows[0].rootViewController as! UINavigationController
        
      //  let activeViewCont = navigationController.visibleViewController
        
      //  kiboLiveChat.handleRemoteNotifications(userInfo, withController: activeViewCont!)
        
        print("app state application is \(UIApplication.sharedApplication().applicationState.rawValue)")
        print("app state is \(application.applicationState.rawValue)")
        print("app state value background is \(UIApplicationState.Background.rawValue)")
        print("app state value inactive is \(UIApplicationState.Inactive.rawValue)")
        print("app state value active is \(UIApplicationState.Active.rawValue)")
       
        
        if (application.applicationState != UIApplicationState.Background) {
            // NSLog("received remote notification \(userInfo)")
           
            
            /*if(socketObj != nil)
            {
                socketObj.socket.emit("logClient","\(username) didReceiveRemoteNotification: ..... \(userInfo["userInfo"]).....\(userInfo.description)")
                print(userInfo["userInfo"])
                
            }
            
            
            if  let singleuniqueid = userInfo["uniqueId"] as? String {
                // Printout of (userInfo["aps"])["type"]
                print("\nFrom APS-dictionary with key \"singleuniqueid\":  \( singleuniqueid)")
                if  let notifType = userInfo["type"] as? String {
                    print("payload of satus or iOS chat")
                    if(notifType=="status")
                    {
                        updateMessageStatus(singleuniqueid, status: (userInfo["status"] as? String)!)
                    }
                    else
                    {
                        
                        fetchSingleChatMessage(singleuniqueid)
                        
                    }
                }
                */
                
                // Do your stuff?
            }
            
            
            print("remote notification received is \(userInfo)")
            /*var notificationJSON=JSON(userInfo)
             print("json converted is \(notificationJSON)")
             print("json received is is \(notificationJSON["aps"])")
             */
        
        kiboLiveChat.handleRemoteNotifications(userInfo, withController: (self.window?.rootViewController)!)
            completionHandler(UIBackgroundFetchResult.NewData)
            NSNotificationCenter.defaultCenter().postNotificationName("ReceivedNotification", object:userInfo)
           
        }
    
    
 
    func application(application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: NSError) {
        
        print("registered for notification error", terminator: "")
        NSLog("Error in registration. Error: \(error)")
    }
   
    
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    
    
        //Add a check if notification origin is "kibo"
        
        UIApplication.sharedApplication().applicationIconBadgeNumber=1;
        UIApplication.sharedApplication().applicationIconBadgeNumber=0;
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
    }

    // MARK: - Core Data stack

    lazy var applicationDocumentsDirectory: NSURL = {
        // The directory the application uses to store the Core Data store file. This code uses a directory named "com.kiboEngage.client.kiboLiveChat" in the application's documents Application Support directory.
        let urls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        return urls[urls.count-1]
    }()

    lazy var managedObjectModel: NSManagedObjectModel = {
        // The managed object model for the application. This property is not optional. It is a fatal error for the application not to be able to find and load its model.
        let modelURL = NSBundle.mainBundle().URLForResource("kiboLiveChat", withExtension: "momd")!
        return NSManagedObjectModel(contentsOfURL: modelURL)!
    }()

    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it. This property is optional since there are legitimate error conditions that could cause the creation of the store to fail.
        // Create the coordinator and store
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let url = self.applicationDocumentsDirectory.URLByAppendingPathComponent("SingleViewCoreData.sqlite")
        var failureReason = "There was an error creating or loading the application's saved data."
        do {
            try coordinator.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: url, options: nil)
        } catch {
            // Report any error we got.
            var dict = [String: AnyObject]()
            dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data"
            dict[NSLocalizedFailureReasonErrorKey] = failureReason

            dict[NSUnderlyingErrorKey] = error as NSError
            let wrappedError = NSError(domain: "YOUR_ERROR_DOMAIN", code: 9999, userInfo: dict)
            // Replace this with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog("Unresolved error \(wrappedError), \(wrappedError.userInfo)")
            abort()
        }
        
        return coordinator
    }()

    lazy var managedObjectContext: NSManagedObjectContext = {
        // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.) This property is optional since there are legitimate error conditions that could cause the creation of the context to fail.
        let coordinator = self.persistentStoreCoordinator
        var managedObjectContext = NSManagedObjectContext(concurrencyType: .MainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = coordinator
        return managedObjectContext
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        if managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
                abort()
            }
        }
    }

}

