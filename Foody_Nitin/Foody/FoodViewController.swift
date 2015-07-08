//
//  ViewController.swift
//  Foody
//
//  Created by npiprava on 7/3/15.
//  Copyright (c) 2015 Nit. All rights reserved.
//

import UIKit
//import CoreData

@objc
protocol FoodViewControllerDelegate{
    
}

class FoodViewController : UIViewController,UITableViewDataSource,UITableViewDelegate,FoodDetailsCellDelegate,UISearchBarDelegate,AutoSearchTableDelegate,SearchViewInterface,servicesDelegate {

    var delegate: FoodViewControllerDelegate?
    var eventHandler: SearchModuleInterface?
    var foodSummaryDataSource: NSMutableArray? = NSMutableArray()
    var cellTapped:Bool = true
    var currentRow = -1;
    var currentIndexPath: NSIndexPath!
    var autoSearchTable:AutoSearchTable!
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var foodTableViewController: UITableView!
    
    override func viewDidLoad() {
        
        //eventHandler = SearchPresenter()
        self.navigationController?.navigationBarHidden = true
         autoSearchTable = storyboard!.instantiateViewControllerWithIdentifier("AutoSearchTable") as! AutoSearchTable
        addChildViewController(autoSearchTable)
        autoSearchTable.view.frame = CGRectMake(5, 64, screenSize.width-10, 200)
        view.addSubview(autoSearchTable.view)
        autoSearchTable.didMoveToParentViewController(self)
        autoSearchTable.view.hidden = true
        autoSearchTable.delegate = self
        
        //self.foodTableViewController.allowsSelection = false;
        self.foodTableViewController.backgroundColor = UIColor(patternImage: UIImage(named: "Background1.jpg")!)
        super.viewDidLoad()
        self.eventHandler!.searchFood("burger")
    }
    
    //Update DataSource Method
    func updateTable(foodObject: Foods) {
        
       self.foodSummaryDataSource!.addObject(foodObject)
       dispatch_async(dispatch_get_main_queue(), {
        
        self.foodTableViewController.reloadData()
        
        })
    }
    

    // MARK: - Table view data source
     func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }
    
     func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let rows : Int!
        if (self.foodSummaryDataSource != nil) {
            rows = self.foodSummaryDataSource!.count
        }
        else {
            rows = 0
        }
        return rows
    }
    
     func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        //Update TableView to expand/collapse Row
        if (currentIndexPath != nil && currentIndexPath.row == indexPath.row)  {
            let foodDetailsCell = tableView.cellForRowAtIndexPath(indexPath) as! FoodDetailsCell
            foodDetailsCell.imgExpandCollapse.image = UIImage(named: "Arrow_Down.png")
            foodDetailsCell.updateCell()
            var selectedIndex:NSIndexPath = currentIndexPath
            currentIndexPath = nil
            tableView.beginUpdates()
            UIView.animateWithDuration(1.0) {
                tableView.reloadRowsAtIndexPaths([selectedIndex], withRowAnimation: UITableViewRowAnimation.Fade)
                tableView.scrollToRowAtIndexPath(indexPath, atScrollPosition: UITableViewScrollPosition.Middle, animated: false)
                
            }
            tableView.endUpdates()
        }
    
        else {
        
        currentIndexPath = indexPath
        currentRow = indexPath.row
        tableView.beginUpdates()
        let foodDetailsCell = tableView.cellForRowAtIndexPath(indexPath) as! FoodDetailsCell
        foodDetailsCell.imgExpandCollapse.image = UIImage(named: "Arrow_Up.png")
        foodDetailsCell.foodImportantsDetails.hidden = false
        //foodDetailsCell.btnDetails.tag = indexPath.row
        tableView.endUpdates()
        tableView.scrollToRowAtIndexPath(indexPath, atScrollPosition: UITableViewScrollPosition.None, animated: false)
        }
    }

    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        //Expand Collapse Row
        if (currentIndexPath != nil)   {
            
            if indexPath.row == currentIndexPath.row {
                return 400
            }
        }
       
        return 82
    }
    

     func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        // Create Cell and return
        let foodDetailsCell = tableView.dequeueReusableCellWithIdentifier("FoodDetailsCell", forIndexPath: indexPath) as! FoodDetailsCell
        foodDetailsCell.delegate = self
        let food  = self.foodSummaryDataSource!.objectAtIndex(indexPath.row) as! Foods
        foodDetailsCell.lblFooName.text = food.foodName
        foodDetailsCell.foodImportantsDetails.foodImportants = food.foodImportants
        foodDetailsCell.foodImportantsDetails.hidden = true
        foodDetailsCell.imgExpandCollapse.image = UIImage(named: "Arrow_Down.png")
        foodDetailsCell.btnAddMeal.tag = indexPath.row
        foodDetailsCell.btnSugarFree.titleLabel?.text = food.isSugerFree ? "SugarFree!" : "Sugar!!!"
        
        return foodDetailsCell
    }

     func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
      func  tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if (editingStyle == UITableViewCellEditingStyle.Delete) {
            
            
        }
    }
    
    //Mark - SearchBar Delegate
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        autoSearchTable.view.hidden = false
        autoSearchTable.filterContentForSearchText(searchText)
    }
    
    func searchSelectedFood (foodName:String) {
        
        autoSearchTable.view.hidden = !autoSearchTable.view.hidden
        self.foodSummaryDataSource?.removeAllObjects()
        self.foodTableViewController.reloadData()
        
         //loda data in background
        dispatch_async(dispatch_get_global_queue(Int(QOS_CLASS_USER_INITIATED.value), 0)) {
            
            self.eventHandler!.searchFood(foodName)
        }
        currentIndexPath = nil
        self.searchBar.resignFirstResponder()
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        autoSearchTable.view.hidden = !autoSearchTable.view.hidden
        self.foodSummaryDataSource?.removeAllObjects()
        self.foodTableViewController.reloadData()
        
        //loda data in background
        dispatch_async(dispatch_get_global_queue(Int(QOS_CLASS_USER_INITIATED.value), 0)) {
            
            self.eventHandler!.searchFood(searchBar.text)
        }
        
        currentIndexPath = nil
        self.foodTableViewController.setContentOffset(CGPointZero, animated: true)
        
        self.searchBar.resignFirstResponder()
    }
    
    //Parallax Effect
    // Note ----> Added parallax effec for foodName only. It can apply to all lables and view or container view. <---Note
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        for cell in self.foodTableViewController.visibleCells()  {
            let foodCell = cell as! FoodDetailsCell
            //foodCell.cellOnTableView(self.foodTableViewController, didScrollOnView: self.view) --> Remove comment to see this parallax effec <----
        }
    }
    
    
    //Mark - DB Operations
    func addMealtoDB(index: Int) {
        //addInteractor?.saveFoodtoDB(index, foodSummaryDataSource: self.foodSummaryDataSource)
        eventHandler?.addMeal(index, DataSource: self.foodSummaryDataSource!)
    }
    
}

