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

public class Groups
{
    func fetchGroups()
    {
        var tblGroups=DatabaseObjectInitialiser.getInstance().database.groups
        do
        {for account in try DatabaseObjectInitialiser.getInstance().database.db.prepare(tblGroups) {
            //print("id: \(account[_id]),
            
        }
        }
        catch{
            print("error")
        }
        var url=Constants.mainURL+Constants.fetchGroups
        var header:[String:String]=["id":""]
        Alamofire.request(.POST,"\(url)",headers:header).response{
            request, response_, data, error in
            print(error)
            
            if response_?.statusCode==200
                
            {
            }
            else{
                
            
            }
        }
    }
}