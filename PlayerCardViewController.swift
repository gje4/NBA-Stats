//
//  PlayerCardViewController.swift
//  Nba Stats
//
//  Created by George Fitzgibbons on 3/11/15.
//  Copyright (c) 2015 Nanigans. All rights reserved.
//

import UIKit

let kPlayerData = "playerData"


class PlayerCardViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    //constant
    let kPlayerData = "playerData"
    
    
    @IBOutlet weak var tableView: UITableView!
    
    //vars
    var baseArray:[[PlayerModel]] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        getRedditJSON("http://adtree.biz/nbaservice.php")
    }
    
    
    
    func getRedditJSON(whichReddit : String){
        let mySession = NSURLSession.sharedSession()
        let url: NSURL = NSURL(string: whichReddit)!
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
                    //                println(salary)
                    
                    
                    
                    var playerData = [PlayerModel(avg_pts:avg_pts!, avg_pts_per_dollar: avg_pts_per_dollar!, game_info:game_info!, mp:mp!, player:player!, position:position!, salary:salary!)]
                    println(playerData)
                    
                    
                    //add to global array
                    self.baseArray.append(playerData);
                    
                    
                    //Broadcast the data to the app
                    //                        NSNotificationCenter.defaultCenter().postNotificationName(self.kPlayerData, object: results)
                    
                    
                    
                    
                    
                    //refresh infromation
                    self.tableView.reloadData()
                    
                    //                        dispatch_async(dispatch_get_main_queue(), {
                    //                            self.tableView!.reloadData()
                    //                        })
                    
                }
            }
            
        })
        networkTask.resume()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //headers for the 2 section of baseArry
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        performSegueWithIdentifier("segueToPlayerCard", sender: self)
        
        println(indexPath.row)
        
        
    }
    
    //UITableViewDelegate
    
    
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        //25 point large for the header
        return 25
    }
    
    //        func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    //            if section == 0 {
    //                return "Average Player Return"
    //            }
    //            else
    //            {
    //                return "Something"
    //            }
    //        }
    
    //UITableViewDataSource
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return baseArray.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //amount of task in global array
        //    println(baseArray[section].count)
        
        return baseArray[section].count
        
        
    }
    
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        println(indexPath.row)
        
        let thisTask = baseArray[indexPath.section][indexPath.row]
        
        //    let thisTask = baseArray[1][indexPath.row]
        
        
        var cell: PlayerCell = tableView.dequeueReusableCellWithIdentifier("playerCell") as PlayerCell
        
        //    let cell: PlayerCell = PlayerCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "playerCell")
        //    let thisTask = self.baseArray[indexPath.section][indexPath.row]
        
        
        //Adding stuff from global array built with Struct TaskModel to cell
        
        cell.playerNameLabel.text = thisTask.player as String
        cell.avgPointsPerDollar.text = thisTask.avg_pts_per_dollar as String
        
        
        return cell
        
        
        
        
        //Example Index path (cell) logic
        
        //        if cell == 0 || cell == 1 || cell == 2 {
        //            //do some logic
        //        }
        
        
        
    }
    
    //UITableViewDelegate
    
    
}
