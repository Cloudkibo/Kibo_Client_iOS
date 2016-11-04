//
//  Groups.swift
//  KiboEngageSDK
//
//  Created by Cloudkibo on 06/09/2016.
//  Copyright © 2016 KiboEngage. All rights reserved.
//

import Foundation
import Alamofire
import SQLite
import UIKit
import SwiftyJSON
//import WindowsAzureMessaging

public class MessageChannels
{
   // var hub:SBNotificationHub!
    public init()
    {
        
    }
    
    public func fetchMessageChannels(completion:(result:Bool, error:String!)->())
    {
        /* var tblGroups=DatabaseObjectInitialiser.getInstance().database.groups
         do
         {for account in try DatabaseObjectInitialiser.getInstance().database.db.prepare(tblGroups) {
         //print("id: \(account[_id]),
         
         }
         }
         catch{
         print("error")
         }
         
         */
        var url=Constants.mainURL+Constants.fetchMessageChannels
        print(url.debugDescription)
        /*
         'kibo-app-id' : '5wdqvvi8jyvfhxrxmu73dxun9za8x5u6n59',
         'kibo-app-secret': 'jcmhec567tllydwhhy2z692l79j8bkxmaa98do1bjer16cdu5h79xvx',
         'kibo-client-id': 'cd89f71715f2014725163952',
         */
        var header:[String:String]=["kibo-app-id":DatabaseObjectInitialiser.getInstance().appid,"kibo-app-secret":DatabaseObjectInitialiser.getInstance().secretid,"kibo-client-id":DatabaseObjectInitialiser.getInstance().clientid]
        var hhh=["headers":"\(header)"]
        print(header.description)
        Alamofire.request(.GET,"\(url)",headers:header).validate().responseJSON { response in
            
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
            
            if(response.result.isSuccess)
            {
                
               // uncomment later  DatabaseObjectInitialiser.getDB().deleteChannelsTableData()
            var channelsData=JSON(response.result.value!)
 
            for(var i=0;i<channelsData.count;i++)
            {
                print("got messagechannels")
                DatabaseObjectInitialiser.getDB().storeMessageChannel(channelsData[i]["_id"].string!, channelname: channelsData[i]["msg_channel_name"].string!, channelDesc: channelsData[i]["msg_channel_description"].string!, compID: channelsData[i]["companyid"].string!, groupID: channelsData[i]["groupid"].string!, creeateby: channelsData[i]["createdby"].string!, datecreation: channelsData[i]["creationdate"].string!, delStatus: channelsData[i]["activeStatus"].string!)
                
                //(groupsData[i]["_id"].string!, deptname1: groupsData[i]["deptname"].string!, deptDesc: groupsData[i]["deptdescription"].string!, compID: groupsData[i]["companyid"].string!, creeateby: "", datecreation: groupsData[i]["creationdate"].string!, delStatus: groupsData[i]["deleteStatus"].string!)
                
                ////  DatabaseObjectInitialiser.getDB().storeGroups("sfsfd", deptname1: "Sdfasdf", deptDesc: "sadfsadf", compID: "Sdfsafd", creeateby: "sdfsaf", datecreation: NSDate().description, delStatus: false)
                
            }
                completion(result: true,error: nil)
            
        }
            else{
                completion(result: false,error: response.result.error?.localizedDescription)
            }
        }
    }
}