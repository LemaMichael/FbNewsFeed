//
//  FriendRequestsController.swift
//  fbNewsFeed
//
//  Created by Michael Lema on 7/29/17.
//  Copyright © 2017 Michael Lema. All rights reserved.
//

import Foundation
import UIKit


class FriendRequestsController : UITableViewController {
    
    static let cellId = "cellId"
    static let headerId = "headerId"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //: Modifying the navigation Bar
        navigationItem.title = "Friend Requests"
        navigationController!.navigationBar.barTintColor = UIColor.rgb(red: 51, green: 90, blue: 149)
        navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        
        tableView.register(FriendRequestCell.self, forCellReuseIdentifier: FriendRequestsController.cellId)
        tableView.register(RequestHeader.self, forHeaderFooterViewReuseIdentifier: FriendRequestsController.headerId)
        
        tableView.separatorColor = UIColor.rgb(red: 229, green: 231, blue: 235)
        tableView.sectionHeaderHeight = 26
        
    }
    
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: FriendRequestsController.cellId, for: indexPath) as! FriendRequestCell
        
        
        if indexPath.row % 3 == 0 {
            
            cell.nameLabel.text = "Mark Zuckerberg"
            cell.requestImageView.image = UIImage(named: "zuckprofile")
            
        } else if indexPath.row % 3 == 1 {
            
            cell.nameLabel.text = "Steve Jobs"
            cell.requestImageView.image = UIImage(named: "steve_profile")
        } else {
            cell.nameLabel.text = "Mahatma Ganhi"
            cell.requestImageView.image = UIImage(named: "gandhi_profile")
        }
        
        cell.requestImageView.backgroundColor = UIColor.black
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: FriendRequestsController.headerId) as! RequestHeader
        
        
        if section == 0 {
            header.nameLabel.text = "FRIEND REQUESTS"
        } else {
            header.nameLabel.text = "PEOPLE YOU MAY KNNOW"
        }
        
        
        return header
    }
    
    //: For when a user taps a row 
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
//    }
    
}
