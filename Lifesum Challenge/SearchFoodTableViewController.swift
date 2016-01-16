//
//  SearchFoodTableViewController.swift
//  Lifesum Challenge
//
//  Created by Pim on 16-01-16.
//  Copyright © 2016 Pim Nijman. All rights reserved.
//

import UIKit

class SearchFoodTableViewController: UITableViewController, UISearchResultsUpdating {

    var foods: [Food] = [] {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    
    // MARK: - Search results updating
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        guard let searchString = searchController.searchBar.text
        else {
            self.foods.removeAll()
            return
        }
        
        self.foods = DataManager().findFoodsForSearchString(searchString)
    }
    
    // MARK: - Table view data source
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.foods.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let food = self.foods[indexPath.row]
        
        let cellReuseIdentifier = "FoodCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellReuseIdentifier) ?? UITableViewCell(style: .Subtitle, reuseIdentifier: cellReuseIdentifier)
        cell.textLabel?.text = food.title
        cell.detailTextLabel?.text = String(format: "%d calories", arguments: [food.calories])
        return cell
    }
    
}
