//
//  ViewController.swift
//  fbNewsFeed
//
//  Created by Michael Lema on 7/25/17.
//  Copyright © 2017 Michael Lema. All rights reserved.
//

import UIKit


//: The methods of this UICollectionViewDelegateFlowLayout define the size of items and the spacing between items in the grid.
class FeedController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let cellId = "cellId"

    
    var posts = [Post]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let postMark = Post()
        postMark.name = "Mark Zuckerberg"
        postMark.statusText =  "I think a simple rule of business is, if you do the things that are easier first, then you can actually make a lot of progress."
        postMark.profileImageName = "zuckprofile"
        postMark.statusImageName = "zuckdog"
        postMark.numLikes = 9996
        postMark.numComments = 340
        posts.append(postMark)
        
        let postSteve = Post()
        postSteve.name = "Steve Jobs"
        postSteve.statusText = "Being the richest man in the cemetery doesn't matter to me. Going to bed at night saying we've done something wonderful, that's what matters to me.\n\n" + "Sometimes when you innovate, you make mistakes. It is best to admit them quickly, and get on with improving your other innovations.\n\n" + "Innovation distinguishes between a leader and a follower."
        postSteve.profileImageName = "steve_profile"
        postSteve.statusImageName = "steve_status"
        postSteve.numLikes = 230
        postSteve.numComments = 1045
        posts.append(postSteve)
        
        let postGandhi = Post()
        postGandhi.name = "Mahatma Gandhi"
        postGandhi.profileImageName = "gandhi_profile"
        postGandhi.statusText = "Live as if you were to die tomorrow; learn as if you were to live forever.\n" + "The weak can never forgive. Forgiveness is the attribute of the strong.\n" + "Happiness is when what you think, what you say, and what you do are in harmony."
        postGandhi.statusImageName = "gandhi_status"
        postGandhi.numLikes = 123
        postGandhi.numComments = 32
        posts.append(postGandhi)
        
        
        
        
        
        navigationItem.title = "News Feed"
        collectionView?.backgroundColor = UIColor(white: 0.95, alpha: 1)
        
        collectionView?.alwaysBounceVertical = true
        
        //: must register a nib or a class for the identifier
        collectionView?.register(FeedCell.self, forCellWithReuseIdentifier: cellId)
        
        
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! FeedCell
        
        cell.post = posts[indexPath.item]
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        //: Estimate the size of the statusTextView
        if let statusText = posts[indexPath.item].statusText {
            
            //: This gives a rough estimate for the entire string's height
            let rect = NSString(string: statusText).boundingRect(with: CGSize(width: view.frame.width, height: 1000) , options: NSStringDrawingOptions.usesFontLeading.union(NSStringDrawingOptions.usesLineFragmentOrigin), attributes: [NSFontAttributeName : UIFont.systemFont(ofSize: 14)], context: nil)
            
            
            
            //: The known height for all views inside the cell
            let knownHeight: CGFloat = 8 + 44 + 4 + 4 + 200 + 8 + 24 + 8 + 44
            
            //: Because scrolling in the textView is disabled, 24 was added to give more spacing
            return CGSize(width: view.frame.width, height: rect.height + knownHeight + 34)
            
        }
        
        
        
        return CGSize(width: view.frame.width, height: 500)
    }
    
    
    //: For when the user rotates device, adjust the layout
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        //: When you change the size of the device, invalidate the layout and redraw the collectionView completely.
        collectionView?.collectionViewLayout.invalidateLayout()
    }
    
    
}


