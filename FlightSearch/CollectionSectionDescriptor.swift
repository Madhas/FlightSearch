//
//  CollectionSectionDescriptor.swift
//  FlightSearch
//
//  Created by Андрей Овсянников on 18.02.2021.
//  Copyright © 2021 home.com. All rights reserved.
//

import UIKit

final class CollectionSectionDescriptor {

    let cellsClass: UICollectionViewCell.Type
    var cellsReusableIdentifier: String {
        String(describing: cellsClass)
    }
    
    let items: [Any]
    let configure: (UICollectionViewCell, IndexPath) -> Void
    
    init<Cell: UICollectionViewCell, Item>(items: [Item],
                                           configure: @escaping (Cell, Item, IndexPath) -> Void) {
        
        cellsClass = Cell.self
        
        self.items = items
        self.configure = { cell, indexPath in
            configure(cell as! Cell, items[indexPath.item], indexPath)
        }
    }
}
