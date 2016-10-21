//
//  syncBulkSMSservice.swift
//  KiboEngageSDK
//
//  Created by Cloudkibo on 21/10/2016.
//  Copyright © 2016 KiboEngage. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
public class syncBulkSMSservice{
    
    public init()
    {
        
    }
    
    func syncBulkSMSfullRefresh(completion:(result:Bool,error:String!)->())
    {
        var url=Constants.mainURL+Constants.getAllBulkSMSListURL
        
        var header:[String:String]=["kibo-app-id":DatabaseObjectInitialiser.getInstance().appid,"kibo-app-secret":DatabaseObjectInitialiser.getInstance().secretid,"kibo-client-id":DatabaseObjectInitialiser.getInstance().clientid]
        var hhh=["headers":"\(header)"]
        
        print("header is \(header.description) and customer id is \(DatabaseObjectInitialiser.getInstance().customerid)")
        
        Alamofire.request(.POST,"\(url)",headers:header).validate().responseJSON { response in
            //request, response_, data, error in
            
            if(response.response!.statusCode==200 || response.response!.statusCode==201)
            {
                /*
                 {
                 "datetime" : "2016-10-17T09:44:44.000Z",
                 "agentid" : [
                 
                 ],
                 "request_id" : "h kaIi5vx 2016 10 17 10 34 4",
                 "agentemail" : [
                 
                 ],
                 "from" : "newCustomer1",
                 "visitoremail" : "newemail@cloudkibo.com",
                 "type" : "message",
                 "messagechannel" : "574db78d23785bca7c650a0f",
                 "uniqueid" : "h fbDyeBH 2016 10 17 14 44 44",
                 "is_seen" : "no",
                 "_id" : "58049d8da4a04c0176b58245",
                 "__v" : 0,
                 "companyid" : "cd89f71715f2014725163952",
                 "msg" : "okk",
                 "to" : "All Agents"
                 },
                 */
                
                print("bulk SMS fetched success")
                print(response.result.description)
                print(".....\(response.data?.description)")
                print(JSON(response.data!))
                print("---\(JSON(response.result.value!))")
                var bulksms=JSON(response.result.value!)
                //save in database
                print("bulk SMS messages \(bulksms)")
                
                
                //uncomment when create bulk sms table
               /* do{
                    try DatabaseObjectInitialiser.getDB().db.run(DatabaseObjectInitialiser.getDB().userschats.delete())
                }
                catch{
                    completion(result: false,error: "error in deleting old chat")
                }*/
                
                var i=0
                
                //uncomment later
                /*for(i=0;i<bulksms.count;i++)
                {
                    var agentid=""
                    var agentemail=""
                    
                    //from mobile is always 1 for communication between mobile client and agent
                    var fromMobile1="yes"
                    
                    
                    /* if(chatMessages[i]["from"].string!==DatabaseObjectInitialiser.getInstance().customerid)
                     {
                     fromMobile1="yes"
                     }*/
                    
                    //     do{
                    var customername=""
                    if((DatabaseObjectInitialiser.getInstance().optionalDataList["customerName"]) != nil)
                    {
                        print("customerName field not nil it exists")
                        customername=DatabaseObjectInitialiser.getInstance().optionalDataList["customerName"] as! String
                        
                        
                    }
                    print("dateeeeeee is \(chatMessages[i]["datetime"]) and type is \(chatMessages[i]["datetime"].type)")
                    
                    
                    
                    
                    let dateFormatter = NSDateFormatter()
                    dateFormatter.timeZone=NSTimeZone.localTimeZone()
                    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
                    //  let datens2 = dateFormatter.dateFromString(date2.debugDescription)
                    //2016-09-18T19:13:00.588Z
                    let datens2 = dateFormatter.dateFromString(chatMessages[i]["datetime"].string!)
                    
                    
                    DatabaseObjectInitialiser.getDB().storeChat(chatMessages[i]["to"].string!, from1: chatMessages[i]["from"].string!, visitoremail1: chatMessages[i]["visitoremail"].string!, type1: chatMessages[i]["type"].string!, uniqueid1: chatMessages[i]["uniqueid"].string!, msg1: chatMessages[i]["msg"].string!, datetime1: datens2!, request_id1: chatMessages[i]["request_id"].string!, messagechannel1: chatMessages[i]["messagechannel"].string!, companyid1: chatMessages[i]["companyid"].string!, is_seen1: chatMessages[i]["is_seen"].string!, fromMobile1: fromMobile1, status1:chatMessages[i]["status"].string!,customername1: customername)
                    // }
                    // catch{
                    //   completion(result: false,error: "error in saving chat")
                    // }
                    
                }
                
                */
                completion(result: true,error: nil)
            }
            else{
                print(response.description)
                print(response.response?.description)
                print("error in fetching bulk sms")
                var errormsg="error in fetching bulk sms"
                if(response.result.error != nil)
                {
                    errormsg=(response.result.error?.localizedDescription)!
                }
                completion(result: false,error: errormsg)
            }
        }
    }
    
    func getSingleBulk()
    {
        var url=Constants.mainURL+Constants.getBulkSMSurl
            
            var header:[String:String]=["kibo-app-id":DatabaseObjectInitialiser.getInstance().appid,"kibo-app-secret":DatabaseObjectInitialiser.getInstance().secretid,"kibo-client-id":DatabaseObjectInitialiser.getInstance().clientid]
            var hhh=["headers":"\(header)"]
            
            print("header is \(header.description) and customer id is \(DatabaseObjectInitialiser.getInstance().customerid)")
            
            Alamofire.request(.POST,"\(url)",parameters: ["customerid":DatabaseObjectInitialiser.getInstance().customerid,"companyid":DatabaseObjectInitialiser.getInstance().clientid],headers:header,encoding: .JSON).validate().responseJSON { response in
                //request, response_, data, error in
                
                if(response.response!.statusCode==200 || response.response!.statusCode==201)
                {
                }
            }
        
    }
    
}