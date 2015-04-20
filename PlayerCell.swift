//
//  PlayerCell.swift
//  Nba Stats
//
//  Created by George Fitzgibbons on 3/6/15.
//  Copyright (c) 2015 Nanigans. All rights reserved.
//

import UIKit

class PlayerCell: UITableViewCell {

    
    @IBOutlet weak var playerNameLabel: UILabel!
    
    @IBOutlet weak var avgPointsPerDollar: UILabel!
    
    @IBOutlet weak var playerPosistionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
