//
//  AppDelegate.swift
//  Lifesum Challenge
//
//  Created by Pim on 12-01-16.
//  Copyright © 2016 Pim Nijman. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        // Set global tint color
        self.window?.tintColor = UIColor(red: 76/255.0, green: 190/255.0, blue: 142/255.0, alpha: 1.0)
        
        // Setup core data stack
        DataManager.setupCoreDataStack()
        
        // Import data from JSON
        if NSUserDefaults.standardUserDefaults().boolForKey("data_loaded") == false {
            
            // Show alert while loading
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                let alertController = UIAlertController(title: "Loading data", message: "\n\n\n", preferredStyle: .Alert)
                let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .Gray)
                activityIndicator.frame = alertController.view.bounds
                activityIndicator.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
                activityIndicator.userInteractionEnabled = false
                activityIndicator.startAnimating()
                alertController.view.addSubview(activityIndicator)
                self.window?.rootViewController?.presentViewController(alertController, animated: true, completion: nil)
            })
            
            do {
                try DataManager().importDataFromJSON({ () -> Void in
                    // Make sure the data won't be loaded the next time the app starts
                    NSUserDefaults.standardUserDefaults().setBool(true, forKey: "data_loaded")
                    
                    // Dismiss loading alert
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        self.window?.rootViewController?.dismissViewControllerAnimated(true, completion: nil)
                    })
                    
                    // Notify table view controllers to update
                    NSNotificationCenter.defaultCenter().postNotificationName("data_is_loaded", object: self)
                })
            } catch {
                // Dismiss loading alert
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.window?.rootViewController?.dismissViewControllerAnimated(true, completion: nil)
                })
                
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

