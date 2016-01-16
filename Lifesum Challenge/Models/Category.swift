//
//  Category.swift
//  Lifesum Challenge
//
//  Created by Pim on 12-01-16.
//  Copyright © 2016 Pim Nijman. All rights reserved.
//

import UIKit
import CoreData

@objc(Category)
class Category: NSManagedObject {
    
    @NSManaged var id: Int
    @NSManaged var title: String
    @NSManaged var food: NSSet
    @NSManaged var headCategoryID: Int
    
}
