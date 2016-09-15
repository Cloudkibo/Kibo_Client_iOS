//
//  GroupsViewController.swift
//  KiboEngageSDK
//
//  Created by Cloudkibo on 07/09/2016.
//  Copyright © 2016 KiboEngage. All rights reserved.
//

import UIKit
import SQLite
public class GroupsViewController: UIViewController,UICollectionViewDelegate, UICollectionViewDataSource {

    
    var GroupsObjectList=[[String:AnyObject]]()
    //var GroupNamesList=[String]()
    
    let _id = Expression<String>("_id")
    let deptname = Expression<String>("deptname")
    let deptdescription = Expression<String>("deptdescription")
    let companyid = Expression<String>("companyid")
    let createdby = Expression<String>("createdby")
    let creationdate = Expression<String>("creationdate")
    let deleteStatus = Expression<String>("deleteStatus")
    
    
    
    let screenSize: CGRect = UIScreen.mainScreen().bounds
    
     @IBOutlet public var collectionViewGroups: UICollectionView!
    
    
    
    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        // Custom initialization
    }
    
    required public init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
    }

    
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        collectionViewGroups.dataSource=self
        collectionViewGroups.delegate=self
        
        GroupsObjectList=DatabaseObjectInitialiser.getDB().getGroupsObjectList()

        // Do any additional setup after loading the view.
    }

    override public func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
   public func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
    
    //collectionViewGroups.frame.width/2-10
    return CGSize(width: collectionViewGroups.bounds.width/2-0.5,height: collectionViewGroups.bounds.height/3)
        //return CGSize(width: 100,height: 100)
    }
 
    
    
    public func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //print("items 6")
        print("cccccc \(GroupsObjectList.count)")
        return GroupsObjectList.count
    }
    
    public func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
        
    }
    public func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        print("cell for row")
        var cell=collectionView.dequeueReusableCellWithReuseIdentifier("FAQsCells", forIndexPath: indexPath) as! GroupsCell
        cell.label1.text=GroupsObjectList[indexPath.row]["deptname"] as! String
        
        
       /* if(indexPath.row==0)
        {print("cell for row \(indexPath)")
        var cell=collectionView.dequeueReusableCellWithReuseIdentifier("FAQsCells", forIndexPath: indexPath) as! GroupsCell
           //  cell.label1.textColor=UIColor.whiteColor()
        return cell
        }
        if(indexPath.row==1)
        {
            print("cell for row \(indexPath)")
            var cell=collectionView.dequeueReusableCellWithReuseIdentifier("FAQsCells1", forIndexPath: indexPath) as! GroupsCell
            
            cell.label2.adjustsFontSizeToFitWidth=true
           // cell.label2.text="Order 1"
           // cell.label2.textColor=UIColor.whiteColor()
            return cell
        }
        if(indexPath.row==2)
        {
            print("cell for row \(indexPath)")
            var cell=collectionView.dequeueReusableCellWithReuseIdentifier("FAQsCells2", forIndexPath: indexPath) as! GroupsCell
            return cell
        }
        if(indexPath.row==3)
        {
            print("cell for row \(indexPath)")
            var cell=collectionView.dequeueReusableCellWithReuseIdentifier("FAQsCells3", forIndexPath: indexPath) as! GroupsCell
            return cell
        }
        if(indexPath.row==4)
        {
          print("cell for row \(indexPath)")
            var cell=collectionView.dequeueReusableCellWithReuseIdentifier("FAQsCells4", forIndexPath: indexPath) as! GroupsCell
            return cell
        }
        else{
            print("cell for row \(indexPath)")
            var cell=collectionView.dequeueReusableCellWithReuseIdentifier("FAQsCells5", forIndexPath: indexPath) as! GroupsCell
            return cell
        }*/
        
        return cell
    }

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
