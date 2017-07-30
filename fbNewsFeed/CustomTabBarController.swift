//
//  CustomTabBarController.swift
//  fbNewsFeed
//
//  Created by Michael Lema on 7/29/17.
//  Copyright © 2017 Michael Lema. All rights reserved.
//

import Foundation
import UIKit

class CustomTabBarController: UITabBarController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layout = UICollectionViewFlowLayout()
        let feedController = FeedController(collectionViewLayout: layout)
        let navigationController = UINavigationController(rootViewController: feedController)
        
        //: Add title and image to the TabBarController
        navigationController.title = "News Feed"
        navigationController.tabBarItem.image = UIImage(named: "news_feed_icon")
        
        //: Creating a second view controller
        let friendRequestsController = FriendRequestsController()
        let secondNavigationController = UINavigationController(rootViewController: friendRequestsController)
        secondNavigationController.title = "Requests"
        secondNavigationController.tabBarItem.image = UIImage(named: "requests_icon")
        
        //: The following navigationControllers will be empty view controllers
        let messengerController = UIViewController()
        messengerController.navigationItem.title = "Messages"
        let thirdNavigationController = UINavigationController(rootViewController: messengerController)
        thirdNavigationController.title = "Messenger"
        thirdNavigationController.tabBarItem.image = UIImage(named: "messenger_icon")
        
        
        let notificationController = UIViewController()
        notificationController.navigationItem.title = "Notifications"
        let fourthNavigationController = UINavigationController(rootViewController: notificationController)
        fourthNavigationController.title = "Notifications"
        fourthNavigationController.tabBarItem.image = UIImage(named: "globe_icon")
        
        
        let moreController = UIViewController()
        moreController.navigationItem.title = "Settings"
        let fifthNavigationController = UINavigationController(rootViewController: moreController)
        fifthNavigationController.title = "More"
        fifthNavigationController.tabBarItem.image = UIImage(named: "more_icon")
       
        
        viewControllers = [navigationController, secondNavigationController, thirdNavigationController, fourthNavigationController, fifthNavigationController]
        
        //: Change tabBarController's transparency
        tabBar.isTranslucent = false
        
        //: Change height of tabBar's line to 0.5 pixels
        let topBorder = CALayer()
        topBorder.frame = CGRect(x: 0, y: 0, width: 1000, height: 0.5)
        topBorder.backgroundColor = UIColor.rgb(red: 229, green: 231, blue: 135).cgColor
        
        tabBar.layer.addSublayer(topBorder)
        tabBar.clipsToBounds = true
 
        
    }
    
}
