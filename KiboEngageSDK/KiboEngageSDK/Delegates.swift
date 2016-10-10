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
    
    static let sharedInstance = Delegates()
    
    class func getInstance() -> Delegates
    {
        return sharedInstance
        
    }
    
    
    private init() {}
    
}