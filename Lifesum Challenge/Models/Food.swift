//
//  Food.swift
//  Lifesum Challenge
//
//  Created by Pim on 12-01-16.
//  Copyright © 2016 Pim Nijman. All rights reserved.
//

import UIKit
import CoreData

@objc(Food)
class Food: NSManagedObject {
    
    @NSManaged var id: Int
    @NSManaged var title: String
    @NSManaged var language: String
    @NSManaged var calories: Int
    @NSManaged var categoryID: Int
    @NSManaged var category: Category
    
}
