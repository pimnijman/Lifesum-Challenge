//
//  Exercise+CoreDataProperties.swift
//  Lifesum Challenge
//
//  Created by Pim on 12-01-16.
//  Copyright © 2016 Pim Nijman. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Exercise {

    @NSManaged var custom: NSNumber?
    @NSManaged var deleted: NSNumber?
    @NSManaged var downloaded: NSNumber?
    @NSManaged var hidden: NSNumber?
    @NSManaged var id: NSNumber?
    @NSManaged var nameDA: String?
    @NSManaged var nameNL: String?
    @NSManaged var namePL: String?
    @NSManaged var namePT: String?
    @NSManaged var photoVersion: NSNumber?
    @NSManaged var nameNO: String?
    @NSManaged var nameSV: String?
    @NSManaged var nameES: String?
    @NSManaged var nameRU: String?
    @NSManaged var nameDE: String?
    @NSManaged var nameFR: String?
    @NSManaged var nameIT: String?
    @NSManaged var lastUpdated: NSDate?
    @NSManaged var addedByUser: UNKNOWN_TYPE
    @NSManaged var title: String?
    @NSManaged var calories: NSNumber?

}
