import UIKit

class FlightsCollectionDataSource: NSObject {

    private(set) var items = [FlightCollectionItem]()
    
    private weak var collectionView: UICollectionView!
    
    init(collectionView: UICollectionView) {
        self.collectionView = collectionView
        
        super.init()
        
        collectionView.register(cellClass: FlightCollectionCell.self)
    }
    
    func update(items: [FlightCollectionItem]) {
        self.items = items
        
        collectionView.reloadData()
    }
}

extension FlightsCollectionDataSource: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeue(FlightCollectionCell.self, for: indexPath)
        cell.configure(with: items[indexPath.item])
        return cell
    }
}
