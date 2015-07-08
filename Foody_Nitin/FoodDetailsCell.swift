//
//  FoodDetailsCell.swift
//  Foody
//
//  Created by npiprava on 7/3/15.
//  Copyright (c) 2015 Nit. All rights reserved.
//

import UIKit
import Foundation
import CoreData


@objc
protocol  FoodDetailsCellDelegate{
    
    optional
    func addMealtoDB (index:Int)
}

class FoodDetailsCell: UITableViewCell {

    @IBOutlet weak var lblFooName: UILabel!
    @IBOutlet weak var btnSugarFree: UIButton!
    @IBOutlet weak var btnAddMeal: UIButton!
    @IBOutlet weak var btnDetails: UIButton!
    @IBOutlet weak var foodImportantsDetails: GraphView!
    @IBOutlet weak var imgExpandCollapse: UIImageView!
    
    var cdataStack =  CDataStack()
    var managedContext: NSManagedObjectContext!
    var delegate: FoodDetailsCellDelegate?
    var isFoodCellSelected = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = UITableViewCellSelectionStyle.Blue
        // Initialization code
    }


    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func updateCell () {
        
        self.imgExpandCollapse.image = UIImage(named: "Arrow_Down.png")
    }
    
    @IBAction func addMeal(sender: AnyObject) {
        
        self.delegate?.addMealtoDB!(sender.tag)
    }
  
    
    
    //Parallax Effect
    
    func differenceinFrame(mainFrame:CGRect, subFrame:CGRect) -> CGFloat {
        
        let differnce = CGRectGetHeight(subFrame) - CGRectGetHeight(mainFrame)
        return differnce
    }
    func cellOnTableView (tableView: UITableView, didScrollOnView view:UIView) {
        
        let rectInSuperView = tableView.convertRect(self.frame, toView: view)
        let distanceFromCenter = CGRectGetHeight(view.frame)/2 - CGRectGetMinY(rectInSuperView)
        let differnceFoodLable = self.differenceinFrame(self.lblFooName.frame, subFrame: rectInSuperView)
        let food_yValue = -(differnceFoodLable/2)+(distanceFromCenter / CGRectGetHeight(view.frame) * differnceFoodLable )
        self.lblFooName.frame = CGRect(x: self.lblFooName.frame.origin.x, y: -(differnceFoodLable/2)+(distanceFromCenter / CGRectGetHeight(view.frame) * differnceFoodLable ), width: self.lblFooName.frame.width, height: self.lblFooName.frame.height)
    }
    
}
