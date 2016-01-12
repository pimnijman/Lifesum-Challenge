//
//  ExerciseTableViewController.swift
//  Lifesum Challenge
//
//  Created by Pim on 12-01-16.
//  Copyright © 2016 Pim Nijman. All rights reserved.
//

import UIKit

class ExerciseTableViewController: UITableViewController {
    
    var exercises: [Exercise] = []
    
    
    var dataLoadedObserver: NSObjectProtocol?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dataLoadedObserver = NSNotificationCenter.defaultCenter().addObserverForName("data_is_loaded", object: nil, queue: NSOperationQueue.mainQueue()) { (notification) -> Void in
            self.refresh()
        }
        
        self.refresh()
    }
    
    deinit {
        if self.dataLoadedObserver != nil {
            NSNotificationCenter.defaultCenter().removeObserver(self.dataLoadedObserver!)
        }
    }
    
    func refresh() {
        self.exercises = Exercise.MR_findAll() as! [Exercise]
        self.tableView.reloadData()
    }

    // MARK: - Table view data source

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.exercises.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let exercise = self.exercises[indexPath.row]
        let cell = tableView.dequeueReusableCellWithIdentifier("ExerciseCell", forIndexPath: indexPath)
        cell.textLabel?.text = exercise.title
        // Format callories by showing only 2 significant figures (e.g. 2.7 calories)
        cell.detailTextLabel?.text = String(format: "%.2g calories", arguments: [exercise.calories])
        return cell
    }

}
