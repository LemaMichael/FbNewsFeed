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
        
        attributedText.append(NSAttributedString(string: "\nDecember 21  •  San Francisco  • ", attributes: [NSFontAttributeName : UIFont.systemFont(ofSize: 12), NSForegroundColorAttributeName : UIColor.rgb(red: 155, green: 161, blue: 161)]))
        
        
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
    
    let likesCommentsLabel: UILabel = {
        let label = UILabel()
        label.text = "388 Likes   10.7K Comments"
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor.rgb(red: 155, green: 161, blue: 171)
        
        return label
    }()
    
    
    let dividerLineView: UIView = {
       let view = UIView()
        view.backgroundColor = UIColor.rgb(red: 226, green: 228, blue: 232)
        return view
    }()
    
    let likeButton =  FeedCell.buttonForTitle(title: "Like", imageName: "like")
    let commentButton = FeedCell.buttonForTitle(title: "Comment", imageName: "comment")
    let shareButton = FeedCell.buttonForTitle(title: "Share", imageName: "share")
    
    
    
    //: We will use this function to create 3 buttons, like, comment and share
    static func buttonForTitle(title: String, imageName: String) -> UIButton {
        let button = UIButton()
        button.setTitleColor(UIColor.rgb(red: 143, green: 150, blue: 163), for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitle(title, for: .normal)
        
        //: spacing from the like button image
        button.titleEdgeInsets = UIEdgeInsetsMake(0, 8, 0, 0)
        
        //: Set the Like button image
        button.setImage(UIImage(named: imageName), for: .normal)
        
        return button
    }
    
    
    override func setUpViews() {
        
        backgroundColor = UIColor.white
        addSubview(nameLabel)
        addSubview(profileImageView)
        addSubview(statusTextView)
        addSubview(statusImageView)
        addSubview(likesCommentsLabel)
        
        addSubview(dividerLineView)
        
        
        addSubview(likeButton)
        addSubview(commentButton)
        addSubview(shareButton)
        
        addConstraintsWithFormat(format: "H:|-8-[v0(44)]-8-[v1]|", views: profileImageView, nameLabel)
        
        addConstraintsWithFormat(format: "H:|-4-[v0]-4-|", views: statusTextView)
        
        addConstraintsWithFormat(format: "H:|[v0]|", views: statusImageView)
        
        addConstraintsWithFormat(format: "H:|-12-[v0]|", views: likesCommentsLabel)
        
        addConstraintsWithFormat(format: "V:|-12-[v0]", views: nameLabel)
        
        addConstraintsWithFormat(format: "H:|-12-[v0]-12-|", views: dividerLineView)
        
        //: Button constraints are here - By specifying v0(v2) & v1(v2), it will share the space equally
        addConstraintsWithFormat(format: "H:|[v0(v2)][v1(v2)][v2]|", views: likeButton, commentButton, shareButton)

        addConstraintsWithFormat(format: "V:|-8-[v0(44)]-4-[v1(30)]-4-[v2]-8-[v3(24)]-8-[v4(0.5)][v5(44)]|", views: profileImageView, statusTextView, statusImageView, likesCommentsLabel, dividerLineView, likeButton)
        
        //: Comment Button & Share Button vertical constraint
        addConstraintsWithFormat(format: "V:[v0(44)]|", views: commentButton)
        addConstraintsWithFormat(format: "V:[v0(44)]|", views: shareButton)
        
    }
    
    
    
}
