//
//  AppDelegate.swift
//  Lifesum Challenge
//
//  Created by Pim on 12-01-16.
//  Copyright © 2016 Pim Nijman. All rights reserved.
//

import UIKit
import MagicalRecord

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        // Set global tint color
        self.window?.tintColor = UIColor(red: 76/255.0, green: 190/255.0, blue: 142/255.0, alpha: 1.0)
        
        // Setup core data stack
        MagicalRecord.setupCoreDataStack()
        
        // Import data from JSON
        if let
            categoriesJSONPath = NSBundle.mainBundle().pathForResource("categoriesStatic", ofType: "json"),
            foodJSONPath = NSBundle.mainBundle().pathForResource("foodStatic", ofType: "json"),
            exercisesJSONPath = NSBundle.mainBundle().pathForResource("exercisesStatic", ofType: "json")
        {
            do {
                
                let categoriesJSONData =    try NSData(contentsOfFile: categoriesJSONPath, options: .DataReadingMappedIfSafe)
                let foodJSONData =          try NSData(contentsOfFile: foodJSONPath, options: .DataReadingMappedIfSafe)
                let exercisesJSONData =     try NSData(contentsOfFile: exercisesJSONPath, options: .DataReadingMappedIfSafe)
                
                if let
                    categoryDicts =         try NSJSONSerialization.JSONObjectWithData(categoriesJSONData, options: []) as? [[String:AnyObject]],
                    foodDicts =             try NSJSONSerialization.JSONObjectWithData(foodJSONData, options: []) as? [[String:AnyObject]],
                    exerciseDicts =         try NSJSONSerialization.JSONObjectWithData(exercisesJSONData, options: []) as? [[String:AnyObject]]
                {
                    print("Importing \(categoryDicts.count) categories")
                    print("Importing \(foodDicts.count) food")
                    print("Importing \(exerciseDicts.count) exercises")
                    
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        // Show alert while loading
                        let alertController = UIAlertController(title: "Loading data", message: "\n\n\n", preferredStyle: .Alert)
                        let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .Gray)
                        activityIndicator.frame = alertController.view.bounds
                        activityIndicator.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
                        activityIndicator.userInteractionEnabled = false
                        activityIndicator.startAnimating()
                        alertController.view.addSubview(activityIndicator)
                        self.window?.rootViewController?.presentViewController(alertController, animated: true, completion: nil)
                    })
                    
                    MagicalRecord.saveWithBlock({ (localContext) -> Void in
                        
                        Category.MR_importFromArray(categoryDicts, inContext: localContext)
                        Food.MR_importFromArray(foodDicts, inContext: localContext)
                        Exercise.MR_importFromArray(exerciseDicts, inContext: localContext)
                        
                    }, completion: { (success, error) -> Void in
                        
                        print("Importing completed")
                        
                        // Dismiss alert
                        self.window?.rootViewController?.dismissViewControllerAnimated(true, completion: nil)
                        
                        // TODO: Notify table view controllers to update
                        
                    })
                }
                
            } catch {
                // TODO: Handle error
            }
        }
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

