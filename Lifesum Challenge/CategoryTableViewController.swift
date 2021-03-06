//
//  CategoryTableViewController.swift
//  Lifesum Challenge
//
//  Created by Pim on 12-01-16.
//  Copyright © 2016 Pim Nijman. All rights reserved.
//

import UIKit

class CategoryTableViewController: UITableViewController {
    
    var categories: [Category] = []
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
        self.categories = DataManager().findAllCategories()
        self.tableView.reloadData()
    }
    
    // MARK: - Actions
    
    @IBAction func searchButtonTapped(sender: AnyObject) {
        let searchResultsController = SearchFoodTableViewController(style: .Plain)
        let searchController = UISearchController(searchResultsController: searchResultsController)
        searchController.searchResultsUpdater = searchResultsController
        searchController.hidesNavigationBarDuringPresentation = false
        self.presentViewController(searchController, animated: true, completion: nil)
    }
    
    // MARK: - Table view data source
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.categories.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let category = self.categories[indexPath.row]
        let cell = tableView.dequeueReusableCellWithIdentifier("CategoryCell", forIndexPath: indexPath)
        cell.textLabel?.text = category.title
        return cell
    }
    
    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        guard let indexPath = self.tableView.indexPathForSelectedRow else { return }
        let category = self.categories[indexPath.row]
        
        let foodTableViewController = segue.destinationViewController as! FoodTableViewController
        foodTableViewController.category = category
    }
    
}
