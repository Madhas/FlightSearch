//
//  CollectionController.swift
//  FlightSearch
//
//  Created by Андрей Овсянников on 18.02.2021.
//  Copyright © 2021 home.com. All rights reserved.
//

import UIKit

class CollectionController: UIViewController {
    
    var collectionViewLayout: UICollectionViewLayout {
        return UICollectionViewFlowLayout()
    }
    
    private(set) lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: self.collectionViewLayout)
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .backgroundPrimary
        collectionView.alwaysBounceVertical = true
        self.view.addSubview(collectionView)
        
        return collectionView
    }()
    var dataSource: CollectionDataSource?
}
