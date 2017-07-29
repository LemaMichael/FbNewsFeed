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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "News Feed"
        collectionView?.backgroundColor = UIColor(white: 0.95, alpha: 1)
         
        collectionView?.alwaysBounceVertical = true
        
        //: must register a nib or a class for the identifier 
        collectionView?.register(FeedCell.self, forCellWithReuseIdentifier: cellId)
        
        
    }

    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 400)
    }
    
    
    //: For when the user rotates device, adjust the layout
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        //: When you change the size of the device, invalidate the layout and redraw the collectionView completely.
        collectionView?.collectionViewLayout.invalidateLayout()
    }


}


