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
        
        // Import exercises
        if let path = NSBundle.mainBundle().pathForResource("exercisesStatic", ofType: "json") {
            do {
                let jsonData = try NSData(contentsOfFile: path, options: .DataReadingMappedIfSafe)
                if let exerciseDicts = try NSJSONSerialization.JSONObjectWithData(jsonData, options: []) as? [[String:AnyObject]] {
                    print("Importing \(exerciseDicts.count) exercises")
                    
                    MagicalRecord.saveWithBlock({ (localContext) -> Void in
                        
                        Exercise.MR_importFromArray(exerciseDicts, inContext: localContext)
                        
                    }, completion: { (success, error) -> Void in
                        
                        let exercises = Exercise.MR_findAll() as! [Exercise]
                        print("Stored \(exercises.count) exercises")
                        
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

