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

public class Teams
{
    
    public init()
    {
        
    }
    
    public func fetchTeams()
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
        var url=Constants.mainURL+Constants.fetchTeams
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
            
            //add success if
            
            
                //print(request)
               // print(response)
                //print(data)
               // print(error)
                /*
                "__v" = 0;
                "_id" = 5745e4da7329b12e16b0e7b7;
                companyid = cd89f71715f2014725163952;
                createdby =         {
                    "__v" = 0;
                    "_id" = 554896ca78aed92f4e6db296;
                    abandonedemail1 = "It seems you have tried to contact us from the email id (insert email id) on the (insert date). Our apologies for making you await long.\nHowever, we have rescheduled your meeting. change this\n\nPlease let us know if there is any question.";
                    abandonedemail2 = "This email is regarding your visit to our company on (insert data). It seems you have tried to contact us regarding the query:\n (user query to be inserted here) \nOur apologies for not communicating to you. However, we have rescheduled your meeting. \nPlease join us\n\nPlease let us know if there is any question.";
                    abandonedemail3 = "It seems you have some query, we can have more conversation on your query (insert query).\n Following is your ticket information: \n (insert information )\n We have scheduled your meeting.\n\nPlease let us know if there is any question.";
                    accountVerified = Yes;
                    allowchime = Yes;
                    allownotification = Yes;
                    canExcludeAgent = Yes;
                    canIncludeAgent = Yes;
                    city = Karachi;
                    companyName = CloudKibo;
                    completedemail1 = "We had conversation on the (insert date). We wanted have more conversation with you.\nWe have scheduled your meeting.\n\nPlease let us know if there is any question.";
                    completedemail2 = "This email is regarding your visit to our company on (insert data). It seems you have tried to contact us regarding the query:\n (user query to be inserted here) \nOur apologies for not communicating to you. However, we have rescheduled your meeting.\n\nPlease let us know if there is any question.";
                    completedemail3 = "Hi we had conversation on the (insert date). We need to discuss more on your query. \n Please join us in the call.  And following is your ticket information: \n (insert information )\n\nPlease let us know if there is any question.";
                    country = Pakistan;
                    date = "2015-05-05T10:09:14.035Z";
                    email = "jekram@hotmail.com";
                    firstname = Jawaid;
                    hashedPassword = "So3+7bKMvsQY8PszIox12lZ/fJNImv+MKQreoCtbH9PrKSrlcoqzLtS3K12PhWFrlDcCzQJk1ZUHkJ1QOGUFYg==";
                    invitedemail1 = "You are invited by agent (insert your name) for a meeting\nPlease join us on (insert date)\n With following URL: (insert URL)\n\nLet us know if you have any question.\n\nThank you.";
                    invitedemail2 = "(insert Domain name) has invited you for the meeting scheduled on (insert date and time)\nPlease join the meeting with following URL (insert URL)\n\nLet us know if you have any question.";
                    invitedemail3 = "Hello, You are invited by agent (insert your name) for a meeting\nPlease join us on (insert date).\n\nPlease let us know if there is any question.\nRegards,";
                    isAdmin = Yes;
                    isAgent = No;
                    isDeleted = No;
                    isOwner = No;
                    isSupervisor = No;
                    lastname = Ekram;
                    phone = 564561324;
                    picture = "6572265071.png";
                    role = admin;
                    salt = "3EkN38cP5st1pdumrLpIOg==";
                    state = Sindh;
                    uniqueid = cd89f71715f2014725163952;
                    website = cloudkibo;
                };
                creationdate = "2016-05-25T17:46:02.664Z";
                deleteStatus = No;
                deptCapital = FINANCE;
                deptdescription = "This group is for finance related issue";
                deptname = Finance;
                */
                ///print(response)
               ///// print(response.result.value)
                var teamsData=JSON(response.result.value!)
                
                for(var i=0;i<teamsData.count;i++)
                {
                    print("got teams")
                    DatabaseObjectInitialiser.getDB().storeTeams(teamsData[i]["_id"].string!, deptname1: teamsData[i]["deptname"].string!, deptDesc: teamsData[i]["deptdescription"].string!, compID: teamsData[i]["companyid"].string!, creeateby: "", datecreation: teamsData[i]["creationdate"].string!, delStatus: teamsData[i]["deleteStatus"].string!)
                    
                  ////  DatabaseObjectInitialiser.getDB().storeGroups("sfsfd", deptname1: "Sdfasdf", deptDesc: "sadfsadf", compID: "Sdfsafd", creeateby: "sdfsaf", datecreation: NSDate().description, delStatus: false)
                    
                }
               
        }
    }
}