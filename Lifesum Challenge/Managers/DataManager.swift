//
//  DataManager.swift
//  Lifesum Challenge
//
//  Created by Pim on 16-01-16.
//  Copyright © 2016 Pim Nijman. All rights reserved.
//

import MagicalRecord

class DataManager {
    
    enum ImportError: ErrorType {
        case MissingResource
        case DataCorruption
    }
    
    
    class func setupCoreDataStack() {
        MagicalRecord.setupCoreDataStack()
    }
    
    func importDataFromJSON(completion: (() -> Void)?) throws {
        guard let
            categoriesJSONPath = NSBundle.mainBundle().pathForResource("categoriesStatic", ofType: "json"),
            foodJSONPath = NSBundle.mainBundle().pathForResource("foodStatic", ofType: "json"),
            exercisesJSONPath = NSBundle.mainBundle().pathForResource("exercisesStatic", ofType: "json")
        else {
            throw ImportError.MissingResource
        }
        
        do {
            
            let categoriesJSONData =    try NSData(contentsOfFile: categoriesJSONPath, options: .DataReadingMappedIfSafe)
            let foodJSONData =          try NSData(contentsOfFile: foodJSONPath, options: .DataReadingMappedIfSafe)
            let exercisesJSONData =     try NSData(contentsOfFile: exercisesJSONPath, options: .DataReadingMappedIfSafe)
            
            guard let
                categoryDicts =         try NSJSONSerialization.JSONObjectWithData(categoriesJSONData, options: []) as? [[String:AnyObject]],
                foodDicts =             try NSJSONSerialization.JSONObjectWithData(foodJSONData, options: []) as? [[String:AnyObject]],
                exerciseDicts =         try NSJSONSerialization.JSONObjectWithData(exercisesJSONData, options: []) as? [[String:AnyObject]]
            else {
                throw ImportError.DataCorruption
            }
            
            print("Importing \(categoryDicts.count) categories")
            print("Importing \(foodDicts.count) food")
            print("Importing \(exerciseDicts.count) exercises")
            
            let importStartTime = NSDate()
            
            MagicalRecord.saveWithBlock({ (localContext) -> Void in
                
                Category.insertFromArray(categoryDicts, inContext: localContext)
                Food.insertFromArray(foodDicts, inContext: localContext)
                Exercise.insertFromArray(exerciseDicts, inContext: localContext)
                
                }, completion: { (success, error) -> Void in
                    
                    print("Importing completed")
                    print("Duration: \(NSDate().timeIntervalSinceDate(importStartTime)) seconds")
                    
                    completion?()
            })
            
        } catch {
            throw ImportError.DataCorruption
        }
    }
    
    func findAllExercises() -> [Exercise] {
        return Exercise.MR_findAllSortedBy("title", ascending: true) as! [Exercise]
    }
    
    func findAllCategories() -> [Category] {
        // Filter categories that are only used as an index
        let predicate = NSPredicate(format: "headCategoryID != %d", 15)
        return Category.MR_findAllSortedBy("title", ascending: true, withPredicate: predicate) as! [Category]
    }
    
    func findFoodsForCategory(category: Category) -> [Food] {
        let predicate = NSPredicate(format: "categoryID == %d AND language == \"en_US\"", category.id)
        return Food.MR_findAllSortedBy("title", ascending: true, withPredicate: predicate) as! [Food]
    }
    
    func findFoodsForSearchString(searchString: String) -> [Food] {
        let predicate = NSPredicate(format: "title CONTAINS[cd] %@ AND language == \"en_US\"", searchString)
        return Food.MR_findAllSortedBy("title", ascending: true, withPredicate: predicate) as! [Food]
    }
    
}
