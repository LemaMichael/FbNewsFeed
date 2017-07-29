//
//  RequestHeaderFooterView.swift
//  fbNewsFeed
//
//  Created by Michael Lema on 7/29/17.
//  Copyright © 2017 Michael Lema. All rights reserved.
//

import Foundation
import UIKit


class BaseHeaderFooterView : UITableViewHeaderFooterView {
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setUpViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpViews() {
    }
}


class RequestHeader: BaseHeaderFooterView {
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "FRIEND REQUESTS"
        label.font = UIFont.systemFont(ofSize: 10)
        label.textColor = UIColor(white: 0.4, alpha: 1)
        return label
    }()
    
    let bottomBorderView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.rgb(red: 229, green: 231, blue: 235)
        return view
    }()
    
    
    override func setUpViews() {
        
        addSubview(nameLabel)
        addSubview(bottomBorderView)
        
        //: Constraints for the nameLabel & bottomBorderView
        addConstraintsWithFormat(format: "H:|-8-[v0]-8-|", views: nameLabel)
        addConstraintsWithFormat(format: "V:|[v0][v1(0.5)]|", views: nameLabel, bottomBorderView)
        addConstraintsWithFormat(format: "H:|[v0]|", views: bottomBorderView)
    }
}
