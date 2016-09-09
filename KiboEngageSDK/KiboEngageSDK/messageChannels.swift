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

public class MessageChannels
{
    
    public init()
    {
        
    }
    
    public func fetchMessageChannels()
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
        var url=Constants.mainURL+Constants.MessageChannels
        print(url.debugDescription)
        /*
         'kibo-app-id' : '5wdqvvi8jyvfhxrxmu73dxun9za8x5u6n59',
         'kibo-app-secret': 'jcmhec567tllydwhhy2z692l79j8bkxmaa98do1bjer16cdu5h79xvx',
         'kibo-client-id': 'cd89f71715f2014725163952',
         */
        var header:[String:String]=["kibo-app-id":DatabaseObjectInitialiser.getInstance().appid,"kibo-app-secret":DatabaseObjectInitialiser.getInstance().secretid,"kibo-client-id":DatabaseObjectInitialiser.getInstance().clientid]
        var hhh=["headers":"\(header)"]
        print(header.description)
        Alamofire.request(.GET,"\(url)",headers:header) .validate()
            .response { request, response, data, error in
                print(request)
                print(response)
                print(data)
                print(error)
        }
    }
}