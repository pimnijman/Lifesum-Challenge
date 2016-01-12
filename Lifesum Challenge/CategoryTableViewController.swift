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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.categories = Category.MR_findAll() as! [Category]
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
    
}
