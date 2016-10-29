//
//  Delegates.swift
//  KiboEngageSDK
//
//  Created by Cloudkibo on 10/10/2016.
//  Copyright © 2016 KiboEngage. All rights reserved.
//

import Foundation


internal class Delegates
{
    var delegateChatDetails1:UpdateChatDetailsDelegate!
    var delegateChannelsDetails1:UpdateChannelsDetailsDelegate!
    var delegateTeamsDetails1:UpdateTeamsDetailsDelegate!

   // var delegateTeamsDetails1:UpdateTeamsDetailsDelegate!
  
    static let sharedInstance = Delegates()
    
    class func getInstance() -> Delegates
    {
        return sharedInstance
        
    }
    
    
    private init() {}
    
    func UpdateChatDetailsDelegateCall()
    {
        if(delegateChatDetails1 != nil)
        {
            delegateChatDetails1?.refreshChatsUI("updateUI", data: nil)
        }
    }
    func UpdateChannelsDetailsDelegateCall()
    {
        if(delegateChannelsDetails1 != nil)
        {
            delegateChannelsDetails1?.refreshChannelsUI("updateUI", data: nil)
        }
    }
    func UpdateTeamsDetailsDelegateCall()
    {
        if(delegateTeamsDetails1 != nil)
        {
            delegateTeamsDetails1?.refreshTeamsUI("updateUI", data: nil)
        }
    }
    
}
protocol UpdateChatDetailsDelegate:class
{
    func refreshChatsUI(message:String,data:AnyObject!);
}
protocol UpdateChannelsDetailsDelegate:class
{
    func refreshChannelsUI(message:String,data:AnyObject!);
}
protocol UpdateTeamsDetailsDelegate:class
{
    func refreshTeamsUI(message:String,data:AnyObject!);
}
