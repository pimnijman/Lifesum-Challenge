//
//  FoodTableViewController.swift
//  Lifesum Challenge
//
//  Created by Pim on 12-01-16.
//  Copyright © 2016 Pim Nijman. All rights reserved.
//

import UIKit

class FoodTableViewController: UITableViewController {
    
    var category: Category?
    var foods: [Food] = []
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
        guard let category = self.category else {
            self.foods = []
            self.tableView.reloadData()
            return
        }
        
        self.foods = DataManager().findFoodsForCategory(category)
        self.tableView.reloadData()
    }
    
    // MARK: - Table view data source
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.foods.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let food = self.foods[indexPath.row]
        let cell = tableView.dequeueReusableCellWithIdentifier("FoodCell", forIndexPath: indexPath)
        cell.textLabel?.text = food.title
        cell.detailTextLabel?.text = String(format: "%d calories", arguments: [food.calories])
        return cell
    }
    
}
