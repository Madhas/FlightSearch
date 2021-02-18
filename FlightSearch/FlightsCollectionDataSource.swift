import UIKit

final class FlightsCollectionDataSource: CollectionDataSource {
    
    func update(items: [FlightCollectionItem]) {
        let section = CollectionSectionDescriptor(items: items) { (cell: FlightCollectionCell, item, indexPath) in
            cell.configure(with: item)
            cell.separatorEnabled = indexPath.item < items.count - 1
        }
        sections = [section]
    }
}
