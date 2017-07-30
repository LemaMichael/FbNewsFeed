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
    
    //: We need a reference to the FeedController
    var feedController: FeedController?
    
    func animatePhoto() {
        feedController?.animateImageView(statusImageView: statusImageView)
    }
    
    var post: Post? {
        didSet {
            
            //: Set the nameLabel
            if let name = post?.name {
                
                let attributedText = NSMutableAttributedString(string: name, attributes: [NSFontAttributeName : UIFont.boldSystemFont(ofSize: 14)])
                
                
                //: Set the city and state
                
                if let state = post?.location?.state, let city = post?.location?.city {
                    
                    attributedText.append(NSAttributedString(string: "\n\(city), \(state)  •  ", attributes: [NSFontAttributeName : UIFont.systemFont(ofSize: 12), NSForegroundColorAttributeName : UIColor.rgb(red: 155, green: 161, blue: 161)]))
                    
                    
                    //: Increase spacing between lines
                    let paragraphStyle = NSMutableParagraphStyle()
                    paragraphStyle.lineSpacing = 4
                    
                    attributedText.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: NSMakeRange(0, attributedText.string.characters.count))
                    
                    //: Add image globe on the right of the label
                    let attachment = NSTextAttachment()
                    attachment.image = UIImage(named: "globe_small")
                    attachment.bounds = CGRect(x: 0, y: -2, width: 12, height: 12)
                    attributedText.append(NSAttributedString(attachment: attachment))
                    
                }
                
                nameLabel.attributedText = attributedText
            }
            
            
            //: Set the statusTextView
            if let statusText = post?.statusText {
                
                statusTextView.text = statusText
                
            }
            
            //: Set the profileImageName
            if let profileImageName = post?.profileImageName {
                
                profileImageView.image = UIImage(named: profileImageName)
                
            }
            
            //: Set the statusImageView
            if let statusImageName = post?.statusImageName {
                
                statusImageView.image = UIImage(named: statusImageName)
                
            }
            
            //: Set the likesCommentsLabel
            if let numLikes = post?.numLikes, let numComments = post?.numComments {
                likesCommentsLabel.text = "\(numLikes) Likes  \(numComments) Comments"
            }
        }
    }
    
    
    let nameLabel: UILabel = {
        let label = UILabel()
        
        //: Show two lines of text for the name and location
        label.numberOfLines = 2
        
        return label
    }()
    
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        //: 1:1 aspect ratio
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = UIColor.red
        return imageView
        
    }()
    
    let statusTextView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: 14)
        
        //: I don't want a user to edit the textView
        textView.isEditable = false
        
        //: I don't want the user to select the text and interact with it.
        textView.isSelectable = false
        
        //: I don't want the textView to be scrollable
        textView.isScrollEnabled = false
        return textView
    }()
    
    let statusImageView: UIImageView = {
        let imageView = UIImageView()
        
        //: ScaleAspectFit uses a 1:1 width-height ratio
        //imageView.contentMode = .scaleAspectFit
        imageView.contentMode = .scaleAspectFill
        
        //: Cut off the extended pixels
        imageView.layer.masksToBounds = true
        
        //: We want to add a gesture recognizer for imageView, therefore make it user interactable
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    let likesCommentsLabel: UILabel = {
        let label = UILabel()
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
        
        //: For when the statusImageView is tapped
        statusImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(animatePhoto)))
        
        addConstraintsWithFormat(format: "H:|-8-[v0(44)]-8-[v1]|", views: profileImageView, nameLabel)
        
        addConstraintsWithFormat(format: "H:|-4-[v0]-4-|", views: statusTextView)
        
        addConstraintsWithFormat(format: "H:|[v0]|", views: statusImageView)
        
        addConstraintsWithFormat(format: "H:|-12-[v0]|", views: likesCommentsLabel)
        
        addConstraintsWithFormat(format: "V:|-12-[v0]", views: nameLabel)
        
        addConstraintsWithFormat(format: "H:|-12-[v0]-12-|", views: dividerLineView)
        
        //: Button constraints are here - By specifying v0(v2) & v1(v2), it will share the space equally
        addConstraintsWithFormat(format: "H:|[v0(v2)][v1(v2)][v2]|", views: likeButton, commentButton, shareButton)
        
        //: All views have a static height except for the statusTextView
        addConstraintsWithFormat(format: "V:|-8-[v0(44)]-4-[v1]-4-[v2(200)]-8-[v3(24)]-8-[v4(0.5)][v5(44)]|", views: profileImageView, statusTextView, statusImageView, likesCommentsLabel, dividerLineView, likeButton)
        
        //: Comment Button & Share Button vertical constraint
        addConstraintsWithFormat(format: "V:[v0(44)]|", views: commentButton)
        addConstraintsWithFormat(format: "V:[v0(44)]|", views: shareButton)
        
    }
    
}
