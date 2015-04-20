//
//  PlayerCardViewController.swift
//  Nba Stats
//
//  Created by George Fitzgibbons on 3/12/15.
//  Copyright (c) 2015 Nanigans. All rights reserved.
//

import UIKit
import CoreData


class PlayerCardViewController: UIViewController {
    
    var detailPlayerModel: PlayerModel!
    
    
    var mainVC: ViewController!

    @IBOutlet weak var gameInfoLabel: UILabel!
    
    @IBOutlet weak var playerNameLabel: UILabel!
    
    @IBOutlet weak var posistionLabel: UILabel!
    
    @IBOutlet weak var averagePointsLabel: UILabel!
    
    @IBOutlet weak var salaryLabel: UILabel!
    
    @IBOutlet weak var averagePointsPerGameLabel: UILabel!
    
    
    //new
    @IBOutlet weak var playersTeamLabel: UILabel!
    
    @IBOutlet weak var minutesPlayedLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        println(self.detailPlayerModel.player)
        // Do any additional setup after loading the view.
        
        self.playersTeamLabel.text = detailPlayerModel.tm
        
        self.minutesPlayedLabel.text = ("Average Minutes = \(detailPlayerModel.mp)")


        self.playerNameLabel.text = detailPlayerModel.player
        
        self.gameInfoLabel.text = detailPlayerModel.game_info

        self.posistionLabel.text = detailPlayerModel.position
        
        self.averagePointsLabel.text = ("Average Points = \(detailPlayerModel.avg_pts)")
        
             self.salaryLabel.text = ("Salary = \(detailPlayerModel.salary)")
        
        self.averagePointsPerGameLabel.text = ("Points Per Doller = \(detailPlayerModel.avg_pts_per_dollar)")




    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func cancelButtonTapped(sender: UIBarButtonItem) {
        //go back function from the nav bar
        self.navigationController?.popViewControllerAnimated(true)
        
    }

    
    @IBAction func addPlayerToWatchListPressed(sender: UIBarButtonItem) {
        
        //access appdelegate
        let appDelegate = (UIApplication.sharedApplication().delegate as AppDelegate)
        
        //access managed object
        let managedObjectContext = appDelegate.managedObjectContext
        
        //format entity
        let entityDescription = NSEntityDescription.entityForName("WatchList", inManagedObjectContext: managedObjectContext!)
        
        //create task
        let playerCard = WatchList(entity: entityDescription!, insertIntoManagedObjectContext: managedObjectContext!)
        
        //add values to task
        playerCard.player = playerNameLabel.text!
        print("coredata/ playerCard.name")
        playerCard.game_info = gameInfoLabel.text!
//        playerCard.mp = mp.text!
        playerCard.position = posistionLabel.text!
        playerCard.avg_pts = averagePointsLabel.text!
        playerCard.salary = salaryLabel.text!
        playerCard.avg_pts_per_dollar = averagePointsPerGameLabel.text!

        //save to appdelagete
        appDelegate.saveContext()
        
        //getting data back
        //requesting enities (taskModels)
        
        var request = NSFetchRequest(entityName: "WatchList")
        var error:NSError? = nil
        var results:NSArray = managedObjectContext!.executeFetchRequest(request, error: &error)!
        
        for res in results {
            println(res)
        }
        

    }
    
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
