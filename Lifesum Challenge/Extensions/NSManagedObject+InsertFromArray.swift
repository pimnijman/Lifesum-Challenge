//
//  NSManagedObject+InsertFromArray.swift
//  Lifesum Challenge
//
//  Created by Pim on 16-01-16.
//  Copyright © 2016 Pim Nijman. All rights reserved.
//

import CoreData

extension NSManagedObject {
    
    /*
     * MagicalRecord's MR_importFromArray uses MR_importFromObject which doesn't simply insert the new object,
     * but first tries to find another object with the same primary attribute and tries to update it.
     * Understandibly, this makes things extremely slow when importing lots of objects.
     *
     * Therefore I've created insertFromArray, which doesn't care about the object's primary attribute and
     * simply inserts all objects.
     * It should only be used when you're certain about your data's integrety.
     */
    
    class func insertFromArray(listOfObjectData: [AnyObject]!, inContext context: NSManagedObjectContext!) -> [AnyObject]! {
        var dataObjects: [AnyObject] = []
        
        for obj in listOfObjectData {
            let dataObject = self.MR_createEntityInContext(context)
            dataObject.MR_importValuesForKeysWithObject(obj)
            dataObjects.append(dataObject)
        }
        
        return dataObjects
    }
    
}
