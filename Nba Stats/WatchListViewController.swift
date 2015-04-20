//
//  WatchListViewController.swift
//  Nba Stats
//
//  Created by George Fitzgibbons on 3/13/15.
//  Copyright (c) 2015 Nanigans. All rights reserved.
//

import UIKit
import CoreData

class WatchListViewController: UIViewController,UITableViewDelegate, UITableViewDataSource,NSFetchedResultsControllerDelegate {

    // Create an empty array of LogItem's
    
    
    @IBOutlet weak var watchListTableView: UITableView!
    
    
    //contant to acess appdelegate
    let managedObjectContext = (UIApplication.sharedApplication().delegate as AppDelegate).managedObjectContext!
    //var to get results of core data entity value
    var fetchResultsController:NSFetchedResultsController = NSFetchedResultsController()

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchResultsController = getFetchedResultsController()
        
        fetchResultsController.delegate = self
        //look for changes
        fetchResultsController.performFetch(nil)

        // Do any additional setup after loading the view.
    }
    
    //view controller function that will refresh data everytime the view is changed
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        fetchResultsController = getFetchedResultsController()
        
        fetchResultsController.delegate = self
        //look for changes
        fetchResultsController.performFetch(nil)
        self.watchListTableView.reloadData()
        
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    //UITableViewDataSource
    
    func numberOfSectionsInTableView(watchListTableView: UITableView) -> Int {
        println(fetchResultsController.sections!.count)

        return fetchResultsController.sections!.count
        
    }
    
    
    func tableView(watchListTableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //number of task
        return fetchResultsController.sections![section].numberOfObjects
        
    }
    func tableView(watchListTableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        let thisPlayer = fetchResultsController.objectAtIndexPath(indexPath) as WatchList
        println(indexPath.row)
        
        var cell: WatchListTableViewCell = watchListTableView.dequeueReusableCellWithIdentifier("watchlist") as WatchListTableViewCell
        //        //Adding stuff from fetchResultsController objectAtIndexPath
        cell.playerNameLabel.text = thisPlayer.player
        cell.averageReturnOnSalary.text = thisPlayer.avg_pts_per_dollar
        cell.salaryLabel.text = thisPlayer.salary
        cell.gameInfoLabel.text = thisPlayer.game_info

        cell.posistionLabel.text = thisPlayer.position
        cell.averagePointsLAbel.text = thisPlayer.avg_pts

        
        //Example Index path (cell) logic
        
        //        if cell == 0 || cell == 1 || cell == 2 {
        //            //do some logic
        //        }
        
        return cell
    }
    
   
    
    //UITableViewDelegate
//    func tableView(watchListTableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
//        
//        println(indexPath.row)
//        
//        
//        performSegueWithIdentifier("watchListToplayerCardSegue", sender: self)
//        
//    }
    
    
    //headers for the 2 section of baseArry
    
//    func tableView(watchListTableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        //25 point large for the header
//        return 25
//    }
//    
//    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        if section == 0 {
//            return "To Do"
//        }
//        else
//        {
//            return "completed"
//        }
//    }
    

    
    
    // NSFetchedResultsControllerDelegate
    
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        watchListTableView.reloadData()
    }
    
    //helpers


    //return an nsfetch request with entity that sorts entities
    func taskFetchRequest() -> NSFetchRequest {
        let fetchRequest = NSFetchRequest(entityName: "WatchList")
        //sort by date
        let sortDescriptor = NSSortDescriptor(key: "player", ascending: true)
        //sort by completed/not
        let completedDescriptor = NSSortDescriptor(key: "position", ascending: true)
        
//        //combine the three lets so entities are sorted
        fetchRequest.sortDescriptors = [completedDescriptor, sortDescriptor]
        //return
        return fetchRequest
    }
    
    //creating a property to have a func to call task fetch
    func getFetchedResultsController() -> NSFetchedResultsController {
        //get data from taskfetchrequest and moniter managed object for changes
        fetchResultsController = NSFetchedResultsController(fetchRequest: taskFetchRequest(), managedObjectContext: managedObjectContext, sectionNameKeyPath: "player", cacheName: nil)
        return fetchResultsController
    }


    func watchListTableView(watchListTableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    //swipe funcitonality to complete a task
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        //access the fetchResultsController indexPath from TaskModel
        
        println(indexPath.section)
        if indexPath.section == 1 {
            let thisTask = fetchResultsController.objectAtIndexPath(indexPath) as WatchList
            
            
            
            // Delete it from the managedObjectContext
            managedObjectContext.deleteObject(thisTask)
            
            // Refresh the table view to indicate that it's deleted
            self.taskFetchRequest()
            
            
            // Tell the table view to animate out that row
//            watchListTableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
            
        } else
        
        {
            let thisTask = fetchResultsController.objectAtIndexPath(indexPath) as WatchList
            
            
            
            // Delete it from the managedObjectContext
            managedObjectContext.deleteObject(thisTask)
            
            // Refresh the table view to indicate that it's deleted
            self.taskFetchRequest()
            
            
            // Tell the table view to animate out that row
//            watchListTableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        }
        
        //save change to task.completed
        (UIApplication.sharedApplication().delegate as AppDelegate).saveContext()
        
        self.watchListTableView.reloadData()
        
    }

        
    }
    
//    func watchListTableView(watchListTableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
//        
//        //access the fetchResultsController indexPath from TaskModel
//        if indexPath.section == 0 {
//        let thisTask = fetchResultsController.objectAtIndexPath(indexPath) as WatchList
//        
//
//        
//        // Delete it from the managedObjectContext
//        managedObjectContext.deleteObject(thisTask)
//        
//            // Refresh the table view to indicate that it's deleted
//            self.taskFetchRequest()
//        
//       
//        // Tell the table view to animate out that row
//        watchListTableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
//        
//        }
//            //save change to task.completed
//            (UIApplication.sharedApplication().delegate as AppDelegate).saveContext()
//            
//        self.watchListTableView.reloadData()
//        
//    }


    
