//
//  FriendRequestCell.swift
//  fbNewsFeed
//
//  Created by Michael Lema on 7/29/17.
//  Copyright © 2017 Michael Lema. All rights reserved.
//

import Foundation
import UIKit

class BaseTableViewCell: UITableViewCell {
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpViews() {
        
    }
    
}

class FriendRequestCell: BaseTableViewCell {
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Sample Name"
        label.font = UIFont.boldSystemFont(ofSize: 12)
        return label
    }()
    
    let requestImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = UIColor.blue
        //: The imageView's content may be clipped to fill the view’s bounds.
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    let confirmButton: UIButton = {
        let button = UIButton()
        button.setTitle("Confirm", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = UIColor.rgb(red: 87, green: 143, blue: 255)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 10)
        button.layer.cornerRadius = 2
        return button
    }()
    
    let deleteButton: UIButton = {
        let button = UIButton()
        button.setTitle("Delete", for: .normal)
        button.setTitleColor(UIColor(white: 0.3, alpha: 1), for: .normal)
        button.layer.cornerRadius = 2
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor(white: 0.7, alpha: 1).cgColor
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 10)
        return button
    }()
    
    
    
    
    override func setUpViews() {
        addSubview(nameLabel)
        addSubview(requestImageView)
        addSubview(confirmButton)
        addSubview(deleteButton)
        
        //: Set the constraints
        addConstraintsWithFormat(format: "H:|-16-[v0(52)]-8-[v1]|", views: requestImageView, nameLabel)
        addConstraintsWithFormat(format: "V:|-4-[v0]-4-|", views: requestImageView)
        addConstraintsWithFormat(format: "V:|-8-[v0]-8-[v1(24)]-8-|", views: nameLabel, confirmButton)
        
        addConstraintsWithFormat(format: "H:|-76-[v0(80)]-8-[v1(80)]", views: confirmButton, deleteButton)
        addConstraintsWithFormat(format: "V:[v0(24)]-8-|", views: deleteButton)
        
        
        
    }
    
}
