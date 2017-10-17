//
//  AppDelegate.swift
//  Sweeper
//
//  Created by Wuming Xie on 10/12/17.
//  Copyright © 2017 team11. All rights reserved.
//

import UIKit
import Parse
import AWSCore
import AWSCognito

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        let configuration = ParseClientConfiguration {
            $0.applicationId = "com.team11.Sweeper"
            $0.server = "http://165.227.6.232:1337/parse"
            $0.isLocalDatastoreEnabled = true
        }
        
        Parse.initialize(with: configuration)

        let credentialsProvider = AWSCognitoCredentialsProvider(regionType:.USEast1, identityPoolId:"us-east-1:39325d1c-04a9-4b41-8a5c-17a7e8dc7ced")
        let awsConfiguration = AWSServiceConfiguration(region:.USEast1, credentialsProvider:credentialsProvider)
        AWSServiceManager.default().defaultServiceConfiguration = awsConfiguration
        
        if User.currentUser != nil {
            self.window?.rootViewController = StoryboardUtils.initVC(storyboard: "Pinviews", identifier: "PinviewsNavigationController")
        }
        
        NotificationCenter.default.addObserver(
            forName: NSNotification.Name(rawValue: User.userDidLogoutKey),
            object: nil,
            queue: OperationQueue.main) { (notification) in
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyboard.instantiateInitialViewController()
                self.window?.rootViewController = vc
        }

        return true
    }
}

