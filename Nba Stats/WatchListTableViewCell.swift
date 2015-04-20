//
//  WatchListTableViewCell.swift
//  Nba Stats
//
//  Created by George Fitzgibbons on 3/16/15.
//  Copyright (c) 2015 Nanigans. All rights reserved.
//

import UIKit

class WatchListTableViewCell: UITableViewCell {

    
    
    @IBOutlet weak var gameInfoLabel: UILabel!
    
    @IBOutlet weak var playerNameLabel: UILabel!
    
    @IBOutlet weak var posistionLabel: UILabel!
    
    
    @IBOutlet weak var salaryLabel: UILabel!
    
    @IBOutlet weak var averageReturnOnSalary: UILabel!
    
    @IBOutlet weak var averagePointsLAbel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

//    @IBAction func morePlayerInfo(sender: AnyObject) {
//        
//
//        
//
//    }
}
