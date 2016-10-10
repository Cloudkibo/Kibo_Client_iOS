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
    
}
protocol UpdateChatDetailsDelegate:class
{
    func refreshChatsUI(message:String,data:AnyObject!);
}