//
//  ScheduleViewController.swift
//  Nba Stats
//
//  Created by George Fitzgibbons on 3/16/15.
//  Copyright (c) 2015 Nanigans. All rights reserved.
//


//
//  ViewController.swift
//  tewt
//
//  Created by George Fitzgibbons on 2/26/15.
//  Copyright (c) 2015 Nanigans. All rights reserved.
//

import UIKit

class ScheduleViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var scheduleTableView: UITableView!
    
    
    //constant
    let kPlayerData = "playerData"
    
    
    
    //vars
    var baseArray:[[ScheduleModel]] = []
    

    
    
   override func viewDidLoad() {
//        super.viewDidLoad()
//        // Do any additional setup after loading the view, typically from a nib.
       getRedditJSON("http://adtree.biz/nbaschedule.php")
    
    }
   
    
    
    func getRedditJSON(whichReddit : String){
        let mySession = NSURLSession.sharedSession()
        let url: NSURL = NSURL(string: whichReddit)!
        let networkTask = mySession.dataTaskWithURL(url, completionHandler : {data, response, error -> Void in
            var err: NSError?
            var results = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &err) as NSArray
            //               println(results)
            
            
            
            //varibales
            
            for(var i = 0; i < results.count; i++){
                if let item = results[i] as? NSDictionary{
                    
               
                   
                    //new value for unique games
                    var game_info: String? = item.valueForKey("game_info") as? String
                                  println(game_info)
             
                    
                    
                    
                    var playerData = [ScheduleModel(game_info:game_info!)]
                    println(playerData)
                    
                    
                    //add to global array
                    self.baseArray.append(playerData);
                    
                    
                    //Broadcast the data to the app
                    //                        NSNotificationCenter.defaultCenter().postNotificationName(self.kPlayerData, object: results)
                    
                    
                    
                    
                    
                    //refresh infromation
                    self.scheduleTableView.reloadData()
                    
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
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        var nav = self.navigationController?.navigationBar
        nav?.barStyle = UIBarStyle.Black
        nav?.tintColor = UIColor.whiteColor()
        nav?.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.orangeColor()]
        

    }
    
    


    
    
    //headers for the 2 section of baseArry
    
    
    
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
    
    
    func numberOfSectionsInTableView(scheduleTableView: UITableView) -> Int {
        
        return baseArray.count
    }
    
    func tableView(scheduleTableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //amount of task in global array
        //    println(baseArray[section].count)
        
        return baseArray[section].count
        
        
    }
    
    
    
    func tableView(scheduleTableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let thisPlayer = baseArray[indexPath.section][indexPath.row]
        
        //    let thisTask = baseArray[1][indexPath.row]
        
        
        var cell: ScheduleCell = scheduleTableView.dequeueReusableCellWithIdentifier("schedule") as ScheduleCell
        
        //    let cell: PlayerCell = PlayerCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "playerCell")
        //    let thisTask = self.baseArray[indexPath.section][indexPath.row]
        
        
        //Adding stuff from global array built with Struct TaskModel to cell
        
        cell.gameInfoLabel.text = thisPlayer.game_info
 
        
        
        
        
        
        //Example Index path (cell) logic
        
               if cell == 0 || cell == 1 || cell == 2 {
                //do some logic
                }
        
        return cell

        
        
        
    }
    
    //UITableViewDelegate

    
    
    
    // Mark - UISearchResultsUpdating
    
    //pull in search filter and refresh
    

    

    
    
    
}
