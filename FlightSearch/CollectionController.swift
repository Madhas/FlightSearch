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
    var dataSource: CollectionDataSource? {
        didSet {
            dataSource?.onUpdate = { [weak self] in
                if self?.dataSource?.sections.count ?? 0 > 0 {
                    self?.loadingView?.removeFromSuperview()
                    self?.infoView?.removeFromSuperview()
                }
                self?.collectionView.reloadData()
            }
        }
    }
    
    private weak var loadingView: LoadingView?
    private weak var infoView: InfoView?
    
    func setLoading() {
        guard loadingView == nil else { return }
        
        let frame = CGRect(x: 0, y: 0, width: collectionView.bounds.width, height: 48)
        let loadingView = LoadingView(frame: frame)
        
        dataSource?.clear()
        collectionView.reloadData()
        
        infoView?.removeFromSuperview()
        collectionView.addSubview(loadingView)
        self.loadingView = loadingView
    }
    
    func setInfo(text: String) {
        guard infoView ==  nil else {
            infoView?.label.text = text
            return
        }
        
        let view = InfoView()
        view.label.font = .systemFont(ofSize: 15)
        view.label.textAlignment = .center
        view.label.textColor = .textSecondary
        view.label.numberOfLines = 4
        view.label.text = text
        
        let height = view.label.sizeThatFits(CGSize(width: collectionView.bounds.width, height: .greatestFiniteMagnitude)).height
        view.frame = CGRect(x: 0, y: 0, width: collectionView.bounds.width, height: height + 48)
        
        loadingView?.removeFromSuperview()
        collectionView.addSubview(view)
        infoView = view
    }
}
