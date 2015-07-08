//
//  AutoSearchTable.swift
//  Foody
//
//  Created by npiprava on 7/6/15.
//  Copyright (c) 2015 Nit. All rights reserved.
//

import UIKit

@objc
protocol AutoSearchTableDelegate {
    optional
    func searchSelectedFood(foodName:String)
}



class AutoSearchTable: UITableViewController,FoodViewControllerDelegate {
    
    var pastSearch = [String]()
    var autoCompleteSearch: Array<String> = []
    var delegate: AutoSearchTableDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.pastSearch.append("Burger")
        self.pastSearch.append("Rice")
        self.pastSearch.append("Pizza")

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func filterContentForSearchText(searchText: NSString) {
        //print("\(searchText)")
        self.autoCompleteSearch.removeAll(keepCapacity: true)
        for curString in self.pastSearch
        {
            if curString.lowercaseString.contains(searchText.lowercaseString as String)
            {
                self.autoCompleteSearch.append(curString)
            }
        }
       self.pastSearch.append(searchText as String)
       self.tableView.reloadData()
    }

    // MARK: - Table view data source

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return autoCompleteSearch.count
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.delegate?.searchSelectedFood!(self.autoCompleteSearch[indexPath.row])
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCellWithIdentifier("SearchCell", forIndexPath: indexPath) as! UITableViewCell
        cell.textLabel!.text = self.autoCompleteSearch[indexPath.row]
        // Configure the cell...
        return cell
    }

}

extension String {
    
    func contains(find: String) -> Bool{
        return self.rangeOfString(find) != nil
    }
}
