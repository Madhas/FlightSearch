import UIKit

class FlightsCollectionDataSource: NSObject {

    private(set) var items = [FlightCollectionItem]()
    
    private weak var collectionView: UICollectionView!
    
    init(collectionView: UICollectionView) {
        self.collectionView = collectionView
        
        super.init()
        
        collectionView.register(cellClass: FlightCollectionCell.self)
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.minimumLineSpacing = .leastNonzeroMagnitude
        }
    }
    
    func update(items: [FlightCollectionItem]) {
        self.items = items
        collectionView.reloadData()
    }
    
    func itemSize(for indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 70)
    }
}

extension FlightsCollectionDataSource: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeue(FlightCollectionCell.self, for: indexPath)
        cell.configure(with: items[indexPath.item])
        cell.separatorEnabled = indexPath.item < items.count - 1
        return cell
    }
}
