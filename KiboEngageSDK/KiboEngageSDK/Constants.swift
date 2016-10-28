//
//  Constants.swift
//  KiboEngageSDK
//
//  Created by Cloudkibo on 07/09/2016.
//  Copyright © 2016 KiboEngage. All rights reserved.
//

import Foundation

internal class Constants
{
    static var mainURL="https://api.kibosupport.com"
    static var fetchTeams="/api/departments"
    static var fetchMessageChannels="/api/messagechannels"
    static var socketurl="http://kiboengage.cloudapp.net"
    static var createBulksessions="/api/visitorcalls/createbulksession"
    static var saveChat="/api/userchats/create"
    
    static var sendChat="http://kiboengage.cloudapp.net/api/getchat"
    
    static var fetchSingleChat="/api/userchats/fetchChat"
    static var getChatSessions="/api/visitorcalls/getcustomersessions"
    static var syncChat="/api/userchats/sync"
    static var partialSyncChat="/api/userchats/partialChatSync"
    static var updateStatus="/api/userchats/updateStatus"
    static var getBulkSMSurl="/api/notifications/fetchbulksms"
    static var getAllBulkSMSListURL="/api/notifications/"
   
}