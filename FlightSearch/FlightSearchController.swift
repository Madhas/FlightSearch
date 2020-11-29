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
}

final class FlightSearchController: UIViewController {
    
    var viewOutput: FlightSearchViewOutput!

    private(set) var collectionView: UICollectionView!
    private var dataSource: FlightsCollectionDataSource!
    
    private var currentKeyboardHeight: CGFloat = 0
    
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
        let layout = UICollectionViewFlowLayout()
        collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .backgroundPrimary
        collectionView.delegate = self
        
        collectionView.contentInset.bottom = currentKeyboardHeight
        collectionView.scrollIndicatorInsets.bottom = currentKeyboardHeight
        
        dataSource = FlightsCollectionDataSource(collectionView: collectionView)
        collectionView.dataSource = dataSource
        
        self.view.addSubview(collectionView)
    }
    
    private func configureSearchBar() {
        guard let navbarBounds = navigationController?.navigationBar.bounds else {
            return
        }
        
        let searchBar = SearchBar(frame: navbarBounds.insetBy(dx: 12, dy: 4))
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
                self.collectionView.contentInset.bottom = self.currentKeyboardHeight
                self.collectionView.scrollIndicatorInsets.bottom = self.currentKeyboardHeight
            }
        }
    }
}

// MARK: FlightSearchViewInput

extension FlightSearchController: FlightSearchViewInput {
    
    func show(items: [FlightCollectionItem]) {
        dataSource.update(items: items)
    }
}

// MARK: UICollectionViewDelegateFlowLayout

extension FlightSearchController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return dataSource.itemSize(for: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        let flight = dataSource.items[indexPath.item].flight
        viewOutput.didSelect(flight: flight)
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
        viewOutput.didEnter(query: text)
    }
}
