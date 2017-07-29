//
//  FeedCell.swift
//  fbNewsFeed
//
//  Created by Michael Lema on 7/28/17.
//  Copyright © 2017 Michael Lema. All rights reserved.
//

import Foundation
import UIKit


class BaseCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpViews() {
    }
}

class FeedCell: BaseCell {
    
    let nameLabel: UILabel = {
        let label = UILabel()
        
        //: Show two lines of text for the name and location
        label.numberOfLines = 2
        
        let attributedText = NSMutableAttributedString(string: "Mark Zuckerberg", attributes: [NSFontAttributeName : UIFont.boldSystemFont(ofSize: 14)])
        
        attributedText.append(NSAttributedString(string: "\nDecember 21  •  San Francisco  • ", attributes: [NSFontAttributeName : UIFont.systemFont(ofSize: 12), NSForegroundColorAttributeName : UIColor(red: 155/255, green: 161/255, blue: 171/255, alpha: 1)]))
        
        
        //: Increase spacing between lines
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 4
        
        attributedText.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: NSMakeRange(0, attributedText.string.characters.count))
        
        //: Add image globe on the right of the label
        let attachment = NSTextAttachment()
        attachment.image = UIImage(named: "globe_small")
        attachment.bounds = CGRect(x: 0, y: -2, width: 12, height: 12)
        attributedText.append(NSAttributedString(attachment: attachment))
        
        
        label.attributedText = attributedText
        
        return label
    }()
    
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        //: 1:1 aspect ratio
        imageView.image = UIImage(named: "zuckprofile")
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = UIColor.red
        return imageView
        
    }()
    
    let statusTextView: UITextView = {
        let textView = UITextView()
        textView.text = "Hello everyone, meet my dog"
        textView.font = UIFont.systemFont(ofSize: 14)
        return textView
    }()
    
    let statusImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.image = UIImage(named: "zuckdog")
        
        //: ScaleAspectFit uses a 1:1 width-height ratio
        //imageView.contentMode = .scaleAspectFit
        imageView.contentMode = .scaleAspectFill
        
        //: Cut off the extended pixels
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    override func setUpViews() {
        
        backgroundColor = UIColor.white
        addSubview(nameLabel)
        addSubview(profileImageView)
        addSubview(statusTextView)
        addSubview(statusImageView)
        
        addConstraintsWithFormat(format: "H:|-8-[v0(44)]-8-[v1]|", views: profileImageView, nameLabel)
        
        addConstraintsWithFormat(format: "H:|-4-[v0]-4-|", views: statusTextView)
        
        addConstraintsWithFormat(format: "H:|[v0]|", views: statusImageView)
        
        addConstraintsWithFormat(format: "V:|-12-[v0]", views: nameLabel)
        addConstraintsWithFormat(format: "V:|-8-[v0(44)]-4-[v1(30)]-4-[v2]|", views: profileImageView, statusTextView, statusImageView)
        
        
    }
    
    
    
}
