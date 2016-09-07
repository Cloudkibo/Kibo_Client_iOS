//
//  GroupsViewController.swift
//  KiboEngageSDK
//
//  Created by Cloudkibo on 07/09/2016.
//  Copyright © 2016 KiboEngage. All rights reserved.
//

import UIKit

public class GroupsViewController: UIViewController,UICollectionViewDelegate, UICollectionViewDataSource {

    
    let screenSize: CGRect = UIScreen.mainScreen().bounds
    
    @IBOutlet weak var collectionViewGroups: UICollectionView!
    
    
    
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

        // Do any additional setup after loading the view.
    }

    override public func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
  /* public func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
    
        return CGSize(width: screenSize.width/3, height: screenSize.height/3);
    }
    */
    
    
    public func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("items 6")
        return 6
    }
    
    public func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
        
    }
    public func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        print("cell for row")
        if(indexPath==0)
        {
        var cell=collectionView.dequeueReusableCellWithReuseIdentifier("FAQsCells", forIndexPath: indexPath) as! GroupsCell
        return cell
        }
        if(indexPath==1)
        {
            var cell=collectionView.dequeueReusableCellWithReuseIdentifier("FAQsCells1", forIndexPath: indexPath) as! GroupsCell
            return cell
        }
        if(indexPath==2)
        {
            var cell=collectionView.dequeueReusableCellWithReuseIdentifier("FAQsCells2", forIndexPath: indexPath) as! GroupsCell
            return cell
        }
        if(indexPath==3)
        {
            var cell=collectionView.dequeueReusableCellWithReuseIdentifier("FAQsCells3", forIndexPath: indexPath) as! GroupsCell
            return cell
        }
        if(indexPath==4)
        {
            var cell=collectionView.dequeueReusableCellWithReuseIdentifier("FAQsCells4", forIndexPath: indexPath) as! GroupsCell
            return cell
        }
        else{
            var cell=collectionView.dequeueReusableCellWithReuseIdentifier("FAQsCells5", forIndexPath: indexPath) as! GroupsCell
            return cell
        }
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
