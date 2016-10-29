//
//  GroupsViewController.swift
//  KiboEngageSDK
//
//  Created by Cloudkibo on 07/09/2016.
//  Copyright © 2016 KiboEngage. All rights reserved.
//

import UIKit
import SQLite
public class TeamsViewController: UIViewController,UICollectionViewDelegate, UICollectionViewDataSource,UpdateTeamsDetailsDelegate {

    var delegateTeams:UpdateTeamsDetailsDelegate!
    var TeamsObjectList=[[String:AnyObject]]()
    //var GroupNamesList=[String]()
    
    let _id = Expression<String>("_id")
    let deptname = Expression<String>("deptname")
    let deptdescription = Expression<String>("deptdescription")
    let companyid = Expression<String>("companyid")
    let createdby = Expression<String>("createdby")
    let creationdate = Expression<String>("creationdate")
    let deleteStatus = Expression<String>("deleteStatus")
    
    
    
    let screenSize: CGRect = UIScreen.mainScreen().bounds
    
     @IBOutlet public var collectionViewTeams: UICollectionView!
    
    
    
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
        
        collectionViewTeams.dataSource=self
        collectionViewTeams.delegate=self
        
        TeamsObjectList=DatabaseObjectInitialiser.getDB().getTeamsObjectList()

        // Do any additional setup after loading the view.
    }
    public override func viewWillAppear(animated: Bool) {
        
        Delegates.sharedInstance.delegateTeamsDetails1=self
    }
    
    func refreshTeamsUI(message: String, data: AnyObject!) {
        
        TeamsObjectList=DatabaseObjectInitialiser.getDB().getTeamsObjectList()
        collectionViewTeams.reloadData()
    }

    override public func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
   public func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
    
    //collectionViewGroups.frame.width/2-10
    return CGSize(width: collectionViewTeams.bounds.width/2-0.5,height: collectionViewTeams.bounds.height/3)
        //return CGSize(width: 100,height: 100)
    }
 
    
    
    public func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //print("items 6")
        print("cccccc \(TeamsObjectList.count)")
        return TeamsObjectList.count
    }
    
    public func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
        
    }
    public func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        print("cell for row")
        var cell=collectionView.dequeueReusableCellWithReuseIdentifier("FAQsCells", forIndexPath: indexPath) as! TeamsCell
        cell.label1.text=TeamsObjectList[indexPath.row]["deptname"] as! String
        
        
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

    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override public func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        //showChannelsSegue
        
        if segue.identifier == "showChannelsSegue" {
            
            if let destinationVC = segue.destinationViewController as? ChannelsViewController{
                let selectedRow = collectionViewTeams.indexPathsForSelectedItems()?.first?.row
                    //.indexPathForSelectedRow!.row
                destinationVC.deptid=TeamsObjectList[selectedRow!]["_id"] as! String
                destinationVC.teamName=TeamsObjectList[selectedRow!]["deptname"] as! String
                
                //destinationVC.participants=self.participantsSelected
                //  let selectedRow = tblForChat.indexPathForSelectedRow!.row
                
            }}
    }
 

}
