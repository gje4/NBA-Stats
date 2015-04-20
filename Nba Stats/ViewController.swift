

    
    //
    //  ViewController.swift
    //  tewt
    //
    //  Created by George Fitzgibbons on 2/26/15.
    //  Copyright (c) 2015 Nanigans. All rights reserved.
    //
    
    import UIKit
    
    class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource,
    UISearchBarDelegate, UISearchControllerDelegate,UISearchResultsUpdating  {
        
        
        var searchController: UISearchController!


        
        @IBOutlet weak var tableView: UITableView!

        //vars
        var baseArray:[[PlayerModel]] = []
        
        
//search
        var apiSearchForPlayers:[String] = []
        
        //search results saved
//        var scopeButtonTitles = ["Active"]
        

        override func viewDidLoad() {
            super.viewDidLoad()
            // Do any additional setup after loading the view, typically from a nib.
            getRedditJSON("http://adtree.biz/nbaservice.php")
            
            
            //search option
            //create porpety
            
            self.searchController = UISearchController(searchResultsController: nil)
            
            //set propritey now
            self.searchController.searchResultsUpdater = self
            
            //screen tackover
            self.searchController.dimsBackgroundDuringPresentation = false
            
            //hide navigation
            self.searchController.hidesNavigationBarDuringPresentation = false
            
            //set up search bar
            self.searchController.searchBar.frame = CGRectMake(self.searchController.searchBar.frame.origin.x, self.searchController.searchBar.frame.origin.y, self.searchController.searchBar.frame.size.width, 44.0)
            
            self.tableView.tableHeaderView = self.searchController.searchBar
            
            //scope buttons for saved, reccomened, search resules
//        self.searchController.searchBar.scopeButtonTitles = scopeButtonTitles
            
            self.searchController.searchBar.delegate = self
            
            //present results in the tableview
            self.definesPresentationContext = true
            
            
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
                        
                 var tm: String? = item.valueForKey("tm") as? String
                                    println(tm )
                
                    
                
                var playerData = [PlayerModel(avg_pts:avg_pts!, avg_pts_per_dollar: avg_pts_per_dollar!, game_info:game_info!, mp:mp!, player:player!, position:position!, salary:salary!, tm:tm!)]
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
        
        override func viewWillAppear(animated: Bool) {
            super.viewWillAppear(animated)
            var nav = self.navigationController?.navigationBar
            nav?.barStyle = UIBarStyle.Black
            nav?.tintColor = UIColor.whiteColor()
            nav?.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.orangeColor()]
        }
       

        
        override func prepareForSegue(segue: UIStoryboardSegue,
            sender: AnyObject?) {
                
                //see if it is going to the detail page
                if segue.identifier == "playerCardSegue" {
                    let detailVC: PlayerCardViewController = segue.destinationViewController as PlayerCardViewController
                    // see what index get selected path(cell) gets pass
                    let indexPath = self.tableView.indexPathForSelectedRow()
                    //get cell from the cell that was selected, section is completed or not, and row is the data
                    let thisTask = baseArray[indexPath!.section][indexPath!.row]
                    //display thisTask that was selected in detailTaskModel
                    detailVC.detailPlayerModel = thisTask
                    //add the detail VC to update
                    detailVC.mainVC = self
                    
                }
        }

        
        
        //headers for the 2 section of baseArry
        

        
        //UITableViewDelegate
        

        
        func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
            //25 point large for the header
            return 25
        }
        
//        func tableView(tableView: UITableView, titleForHeaderInSection section: Int, indexPath: NSIndexPath) -> String? {
//            if section != 0 {
//              let thisPlayer = baseArray[indexPath.section][indexPath.row]
//                
//                return   ("Return \(thisPlayer.avg_pts_per_dollar) X")
//            }
//            else
//            {
//                
//                let thisPlayer = baseArray[indexPath.section][indexPath.row]
//
//                return   ("Return \(thisPlayer.avg_pts_per_dollar) X")
//
//            }
//        }

//UITableViewDataSource


        func numberOfSectionsInTableView(tableView: UITableView) -> Int {
            
            return baseArray.count
        }
        
        func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            //amount of task in global array
//               println(baseArray[section].count)
            
            return baseArray[section].count
            
            
        }

        

func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    
    println(indexPath.row)

    let thisPlayer = baseArray[indexPath.section][indexPath.row]
    
//    let thisTask = baseArray[1][indexPath.row]

    
    var cell: PlayerCell = tableView.dequeueReusableCellWithIdentifier("playerCell") as PlayerCell
    
    
    
    
//    let cell: PlayerCell = PlayerCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "playerCell")
//    let thisTask = self.baseArray[indexPath.section][indexPath.row]

    
    //Adding stuff from global array built with Struct TaskModel to cell

    cell.playerNameLabel.text = thisPlayer.player
    cell.avgPointsPerDollar.text = ("Return \(thisPlayer.avg_pts_per_dollar) X")
   cell.playerPosistionLabel.text = thisPlayer.position

    
    
    return cell
    
  


    //Example Index path (cell) logic
    
    //        if cell == 0 || cell == 1 || cell == 2 {
    //            //do some logic
    //        }
    
    

}
        
          //UITableViewDelegate
          func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
            performSegueWithIdentifier("playerCardSegue", sender: self)

            println(indexPath.row)
 
            
        }
        
        
        
        
        //pull in search filter and refresh
        
        func updateSearchResultsForSearchController(searchController: UISearchController) {
            //text
            let searchString = self.searchController.searchBar.text
            let selectedScopeButtonIndex = self.searchController.searchBar.selectedScopeButtonIndex
            self.filterContentForSearch(searchString, scope: selectedScopeButtonIndex)
            // reload data
            self.tableView.reloadData()
        }
        //search bar helper
        
        func filterContentForSearch (searchText: String, scope: Int) {
            self.apiSearchForPlayers = self.apiSearchForPlayers.filter({ (food : String) -> Bool in
                //text in search bar
                var foodMatch = food.rangeOfString(searchText)
                //do not return none matchs
                return foodMatch != nil
            })
        }
        
        //MARK - UISearchBarDelegate
        func searchBarSearchButtonClicked(searchBar: UISearchBar) {
            self.searchController.searchBar.selectedScopeButtonIndex = 1
            
            //get passed into the http request
//        self.makeRequest(searchBar.text)
        }
        
        //update search bar
        func searchBar(searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
            self.tableView.reloadData()
        }

        
        
        @IBAction func watchListButtonPressed(sender: AnyObject) {
            
            
            performSegueWithIdentifier("playerWatchListSegue", sender: self)
            
            
        }
        
        
        @IBAction func scheduleButtonPressed(sender: AnyObject) {
            
            performSegueWithIdentifier("scheduleSegue", sender: self)
        }

        
        
        

  
}
