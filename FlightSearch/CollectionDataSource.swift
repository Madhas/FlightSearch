//
//  CollectionDataSource.swift
//  FlightSearch
//
//  Created by Andrey Ovsyannikov on 18.02.2021.
//  Copyright © 2021 home.com. All rights reserved.
//

import UIKit

class CollectionDataSource: NSObject {
    
    var onUpdate: (() -> Void)?

    var sections: [CollectionSectionDescriptor] = [] {
        didSet {
            onUpdate?()
        }
    }
    
    private var registeredIdentifiers: Set<String> = []
    
    func clear() {
        sections = []
    }
}

extension CollectionDataSource: UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sections[section].items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let section = sections[indexPath.section]
        if !registeredIdentifiers.contains(section.cellsReusableIdentifier) {
            collectionView.register(section.cellsClass, forCellWithReuseIdentifier: section.cellsReusableIdentifier)
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: section.cellsReusableIdentifier, for: indexPath)
        section.configure(cell, indexPath)
        return cell
    }
}
