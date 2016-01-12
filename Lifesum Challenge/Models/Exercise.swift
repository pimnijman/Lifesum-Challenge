//
//  Exercise.swift
//  Lifesum Challenge
//
//  Created by Pim on 12-01-16.
//  Copyright © 2016 Pim Nijman. All rights reserved.
//

import UIKit
import CoreData

@objc(Exercise)
class Exercise: NSManagedObject {
    
    @NSManaged var id: Int
    @NSManaged var title: String
    @NSManaged var nameDA: String
    @NSManaged var nameDE: String
    @NSManaged var nameES: String
    @NSManaged var nameFR: String
    @NSManaged var nameIT: String
    @NSManaged var nameNL: String
    @NSManaged var nameNO: String
    @NSManaged var namePL: String
    @NSManaged var namePT: String
    @NSManaged var nameRU: String
    @NSManaged var nameSV: String
    @NSManaged var calories: Float
    @NSManaged var addedByUser: Bool
    @NSManaged var custom: Bool
    @NSManaged var removed: Bool
    @NSManaged var downloaded: Bool
    @NSManaged var hidden: Bool
    @NSManaged var photoVersion: Int
    @NSManaged var lastUpdated: NSDate

}
