//
//  WatchList.swift
//  Nba Stats
//
//  Created by George Fitzgibbons on 3/16/15.
//  Copyright (c) 2015 Nanigans. All rights reserved.
//

import Foundation
import CoreData
@objc(WatchList)


class WatchList: NSManagedObject {

    @NSManaged var avg_pts: String
    @NSManaged var avg_pts_per_dollar: String
    @NSManaged var game_info: String
    @NSManaged var mp: String
    @NSManaged var player: String
    @NSManaged var position: String
    @NSManaged var salary: String

}
