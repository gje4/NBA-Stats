//
//  PlayerData.swift
//  Nba Stats
//
//  Created by George Fitzgibbons on 3/12/15.
//  Copyright (c) 2015 Nanigans. All rights reserved.
//

import Foundation

var baseArray:[[PlayerModel]] = []

let NBADataurl = "http://adtree.biz/nbaservice.php"
class DataManager {


func getRedditJSON(NBADataurl : String){
    let mySession = NSURLSession.sharedSession()
    let url: NSURL = NSURL(string: NBADataurl)!
    let networkTask = mySession.dataTaskWithURL(url, completionHandler : {data, response, error -> Void in
        var err: NSError?
        var results = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &err) as NSArray
        //               println(results)
        
        
        //
        //                for(var i = 0; i < results.count; i++){
        //                    if let item = results[i] as? NSDictionary {
        //                        if let avg_pts = item["avg_pts"] as? String{
        //
        //                        }
        //                        if let avg_pts_per_dollar = item["avg_pts_per_dollar"] as? String{
        //                        }
        //                        if let game_info = item["game_info"] as? String{
        //                        }
        //                        if let mp = item["mp"] as? String{
        //                        }
        //                        if let player = item["player"] as? String{
        //                        }
        //                        if let position = item["position"] as? String{
        //                        }
        //                        if let salary = item["salary"] as? String{
        //                        }
        //
        //                    }
        //                }
        
        //varibales
        
        for(var i = 0; i < results.count; i++){
            if let item = results[i] as? NSDictionary{
                
                var avg_pts: String? = item.valueForKey("avg_pts") as? String
                //                println(avg_pts)
                
                
                var avg_pts_per_dollar: String? = item.valueForKey("avg_pts_per_dollar") as? String
                println(avg_pts_per_dollar)
                
                var game_info: String? = item.valueForKey("game_info") as? String
                //                println(game_info)
                
                var mp: String? = item.valueForKey("mp") as? String
                //                println(mp)
                
                var player: String? = item["player"] as? String
                //                println(player)
                var position: String? = item.valueForKey("position") as? String
                //                println(position)
                var salary: String? = item.valueForKey("salary") as? String
                              println(salary)
                
                
                
                var playerData = [PlayerModel(avg_pts:avg_pts!, avg_pts_per_dollar: avg_pts_per_dollar!, game_info:game_info!, mp:mp!, player:player!, position:position!, salary:salary!)]
                println(playerData)
                
                
                //add to global array
               baseArray.append(playerData);
                
                
                //Broadcast the data to the app
                //                        NSNotificationCenter.defaultCenter().postNotificationName(self.kPlayerData, object: results)
                
                
                
                
                
                //refresh infromation
                
                //                        dispatch_async(dispatch_get_main_queue(), {
                //                            self.tableView!.reloadData()
                //                        })
                
            }
        }
        
    })
    networkTask.resume()
}

}