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
        
        Alamofire.request(.GET,"\(url)",headers:header).validate().responseJSON { response in
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
                
              // var bulksms=bulksmsOuter[0]
                //uncomment when create bulk sms table
                do{
                    try DatabaseObjectInitialiser.getDB().db.run(DatabaseObjectInitialiser.getDB().bulkSMStable.delete())
                }
                catch{
                    completion(result: false,error: "error in deleting old bulk sms table")
                }
                
                var i=0
                print("bulk sms count is \(bulksms.count)")
                
                //uncomment later
                for(i=0;i<bulksms.count;i++)
                {
                print("bulk sms count is \(bulksms.count)")
                    
                    
                    
                    let dateFormatter = NSDateFormatter()
                    dateFormatter.timeZone=NSTimeZone.localTimeZone()
                    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
                    //  let datens2 = dateFormatter.dateFromString(date2.debugDescription)
                    //2016-09-18T19:13:00.588Z
                    let datens2 = dateFormatter.dateFromString(bulksms[i]["datetime"].string!)
                    
                    var imgurl=""
                    if(bulksms[i]["image_url"] != nil)
                    {
                        imgurl=bulksms[i]["image_url"].string!
                    }
                    DatabaseObjectInitialiser.getDB().storeBulkSMS(bulksms[i]["title"].string!, description1: bulksms[i]["description"].string!, agent_id1: bulksms[i]["agent_id"].string!, hasImage1: bulksms[i]["hasImage"].string!, image_url1: imgurl, companyid1: bulksms[i]["companyid"].string!, datetime1: datens2!)
                    // }
                    // catch{
                    //   completion(result: false,error: "error in saving chat")
                    // }
                    
                }
                
 
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