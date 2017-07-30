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
        
        
        //: parse file
        if let path = Bundle.main.path(forResource: "all_posts", ofType: "json") {
            
            do {
                
                
                let data = try(Data(contentsOf: URL(fileURLWithPath: path), options: NSData.ReadingOptions.mappedIfSafe))
                
                let jsonDictionary = try(JSONSerialization.jsonObject(with: data, options: .mutableContainers)) as? [String: Any]
                
                
                if let postsArray = jsonDictionary?["posts"] as? [[String : Any]] {
                    
                    self.posts = [Post]()
                    
                    for postDictionary in postsArray {
                        let post = Post()
                        post.setValuesForKeys(postDictionary)
                        self.posts.append(post)
                    }
                }
                
            } catch let err {
                print(err)
                
            }
        }
        

        
        //: Modifying the navigationBar
        navigationItem.title = "News Feed"
        navigationController!.navigationBar.barTintColor = UIColor.rgb(red: 51, green: 90, blue: 149)
        navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.white]
        
        /*
         //: Will be parsing a file to get data instead.
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
         */
        
        
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
        
        cell.feedController = self
        
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
    
    
    var statusImageView: UIImageView?
    let zoomImageView = UIImageView()
    //: The following line will be used to display a black view when an image is tapped
    let blackBackgroundView = UIView()
    let navBarCoverView = UIView()
    let tabBarCoverView = UIView()
    
    
    
    //: To animate statusImageView
    func animateImageView(statusImageView: UIImageView) {
        
        self.statusImageView = statusImageView
        
        if let startingFrame = statusImageView.superview?.convert(statusImageView.frame, to: nil) {
            
            //: Make the original image in the cell completely transparent
            statusImageView.alpha = 0
            
            
            //: Set the blackBackgroumdView
            blackBackgroundView.frame = self.view.frame
            blackBackgroundView.backgroundColor = UIColor.black
            blackBackgroundView.alpha = 0
            view.addSubview(blackBackgroundView)
            
            //: Cover the navigation bar when the user taps the statusImage (20 pixels for the status bar and 44 pixels for the nav. bar
            navBarCoverView.frame = CGRect(x: 0, y: 0, width: 1000, height: 20 + 44)
            navBarCoverView.backgroundColor = UIColor.black
            navBarCoverView.alpha = 0
            
            
            //: We need to cover the navBar & TabBar and adding them to the view won't help. The following line will help us accomplish our desire.
            if let keyWindow = UIApplication.shared.keyWindow {
                
                //: Cover the tabBar when the user taps the statusImage, the tab bar is roughly 49 pixels
                tabBarCoverView.frame = CGRect(x: 0, y: (keyWindow.frame.height - 49), width: 1000, height: 49)
                tabBarCoverView.backgroundColor = UIColor.black
                tabBarCoverView.alpha = 0
                
                keyWindow.addSubview(navBarCoverView)
                keyWindow.addSubview(tabBarCoverView)
            }
            
            
            zoomImageView.frame = startingFrame
            zoomImageView.isUserInteractionEnabled = true
            zoomImageView.image = statusImageView.image
            //: Without the following line of code, the image will be compressed
            zoomImageView.contentMode = .scaleAspectFill
            zoomImageView.clipsToBounds = true
            view.addSubview(zoomImageView)
            
            
            
            //: Animate the view to move its position to the center
            UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
                
                //: W1/W2 = H1/H2, therefore the new height will be h2 = h1 (w2 / w1)
                let height = startingFrame.height * (self.view.frame.width / startingFrame.width)
                
                let yPosition = (self.view.frame.height / 2) - (height / 2)
                self.zoomImageView.frame = CGRect(x: 0, y: yPosition, width: self.view.frame.width, height: height)
                
                self.blackBackgroundView.alpha = 1
                self.navBarCoverView.alpha = 1
                self.tabBarCoverView.alpha = 1
            }, completion: nil)
            
            
            //: For when the user taps the image again
            zoomImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(zoomOutPhoto)))
            
        }
        
    }
    
    
    
    
    func zoomOutPhoto() {
        
        if let startingFrame = statusImageView!.superview?.convert(statusImageView!.frame, to: nil) {
            
            
            UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
                
                //: Put image back to its initial position
                self.zoomImageView.frame = startingFrame
                
                //: Set the blackBackgroundView, navBarCoverView & tabBarCoverView alpha to be transparent
                self.blackBackgroundView.alpha = 0
                self.navBarCoverView.alpha = 0
                self.tabBarCoverView.alpha = 0
                
            }, completion: { (didComplete) in
                //: Now that the user tapped the new image (zoomImageView) again, remove it from the superview along with the black colored views
                self.zoomImageView.removeFromSuperview()
                self.blackBackgroundView.removeFromSuperview()
                self.navBarCoverView.removeFromSuperview()
                self.tabBarCoverView.removeFromSuperview()
                
                //: Set the original statusImage's alpha back to 1
                self.statusImageView?.alpha = 1
            })
            
            
            
        }
        
    }
    
    
    
    
    
    
    
}


