//
//  FlightSearchController.swift
//  FlightSearch
//
//  Created by Андрей Овсянников on 13.09.2020.
//  Copyright © 2020 home.com. All rights reserved.
//

import UIKit

protocol FlightSearchViewInput: AnyObject {
    
    func show(items: [FlightCollectionItem])
    func show(error: Error)
}

final class FlightSearchController: CollectionController {
    
    var viewOutput: FlightSearchViewOutput!
    
    private var currentKeyboardHeight: CGFloat = 0
    
    override var collectionViewLayout: UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = .leastNonzeroMagnitude
        return layout
    }
    
    private var flightDataSource: FlightsCollectionDataSource {
        return dataSource as! FlightsCollectionDataSource
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardChangeFrame(_:)),
                                               name: UIResponder.keyboardWillChangeFrameNotification,
                                               object: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureCollectionView()
        configureSearchBar()
    }
    
    private func configureCollectionView() {
        collectionView.delegate = self
        
        collectionView.contentInset.bottom = currentKeyboardHeight
        collectionView.scrollIndicatorInsets.bottom = currentKeyboardHeight
        
        dataSource = FlightsCollectionDataSource()
        collectionView.dataSource = dataSource
    }
    
    private func configureSearchBar() {
        guard let navbarBounds = navigationController?.navigationBar.bounds else {
            return
        }
        
        let searchBar = SearchBar(frame: navbarBounds.insetBy(dx: 12, dy: 4))
        searchBar.placeholder = .searchPlaceholder
        searchBar.delegate = self
        navigationItem.titleView = searchBar
    }
    
    @objc private func keyboardChangeFrame(_ notification: Notification) {
        guard let frameValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue,
              let animationDuration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber else {
            return
        }
        
        currentKeyboardHeight = frameValue.cgRectValue.origin.y < view.frame.maxY ? frameValue.cgRectValue.height : 0
        if isViewLoaded {
            UIView.animate(withDuration: animationDuration.doubleValue) {
                let inset = self.currentKeyboardHeight > 0 ? self.currentKeyboardHeight - self.view.safeAreaInsets.bottom : 0
                self.collectionView.contentInset.bottom = inset
                self.collectionView.scrollIndicatorInsets.bottom = inset
            }
        }
    }
}

// MARK: FlightSearchViewInput

extension FlightSearchController: FlightSearchViewInput {
    
    func show(items: [FlightCollectionItem]) {
        flightDataSource.update(items: items)
    }
    
    func show(error: Error) {
        if let error = error as? LocalError {
            setInfo(text: error.description)
        } else {
            setInfo(text: error.localizedDescription)
        }
    }
}

// MARK: UICollectionViewDelegateFlowLayout

extension FlightSearchController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 70)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        let section = flightDataSource.sections[indexPath.section]
        if let flight = section.items[indexPath.item] as? FlightCollectionItem {
            viewOutput.didSelect(flight: flight.flight)
        }
    }
}

// MARK: SearchBarDelegate

extension FlightSearchController: SearchBarDelegate {

    func searchBarShouldBeginEditing(_ searchBar: SearchBar) -> Bool {
        searchBar.showCancelButton(true, animated: true)
        return true
    }
    
    func searchBarCancelButtonTapped(_ searchBar: SearchBar) {
        searchBar.text = ""
        searchBar.resignFirstResponder()
        searchBar.showCancelButton(false, animated: true)
        viewOutput.didEnter(query: "")
    }
    
    func searchBarSearchButtonTapped(_ searchBar: SearchBar) {
        searchBar.resignFirstResponder()
        searchBar.showCancelButton(false, animated: true)
    }
    
    func searchBar(_ searchBar: SearchBar, textDidChange text: String) {
        setLoading()
        viewOutput.didEnter(query: text)
    }
}
