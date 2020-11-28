//
//  SearchBar.swift
//  FlightSearch
//
//  Created by Андрей Овсянников on 28.11.2020.
//  Copyright © 2020 home.com. All rights reserved.
//

import UIKit

protocol SearchBarDelegate: AnyObject {
    
    func searchBarShouldBeginEditing(_ searchBar: SearchBar) -> Bool
    func searchBarCancelButtonTapped(_ searchBar: SearchBar)
    func searchBarSearchButtonTapped(_ searchBar: SearchBar)
    func searchBar(_ searchBar: SearchBar, textDidChange text: String)
}

final class SearchBar: UIView {

    weak var delegate: SearchBarDelegate?
    
    var text: String? {
        set {
            textField.text = newValue
        }
        get {
            textField.text
        }
    }
    
    var placeholder: String? {
        set {
            let attributes: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.textPlaceholder,
                                                             .font: UIFont.systemFont(ofSize: 17)]
            textField.attributedPlaceholder = NSAttributedString(string: newValue ?? "", attributes: attributes)
        }
        get {
            textField.attributedPlaceholder?.string
        }
    }
    
    private let textField = SearchBarTextField()
    private let cancelButton = UIButton(type: .custom)
    private var cancelButtonShown = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func showCancelButton(_ show: Bool, animated: Bool) {
        cancelButton.isHidden = false
        cancelButtonShown = show
        
        let animation = {
            var textFrame = self.textField.frame
            var cancelFrame = self.cancelButton.frame
            
            textFrame.size.width = show ? self.bounds.width - 12 - cancelFrame.width : self.bounds.width
            cancelFrame.origin.x = textFrame.maxX + 12
            
            self.textField.frame = textFrame
            self.cancelButton.frame = cancelFrame
        }
        
        let completion = { (finished: Bool) in
            self.cancelButton.isHidden = !show
        }
        
        if animated {
            UIView.animate(withDuration: CATransaction.animationDuration(), animations: animation, completion: completion)
        } else {
            animation()
            completion(true)
        }
    }
    
    // MARK: Private
    
    private func configureView() {
        textField.backgroundColor = .searchBackground
        textField.layer.cornerRadius = 10
        textField.textColor = .textPrimary
        textField.font = .systemFont(ofSize: 17)
        textField.returnKeyType = .search
        textField.enablesReturnKeyAutomatically = true
        textField.delegate = self
        textField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        addSubview(textField)
        
        cancelButton.isHidden = true
        cancelButton.titleLabel?.font = .systemFont(ofSize: 17)
        
        let highlighted = UIColor.searchAccent.withAlphaComponent(0.6)
        cancelButton.setTitleColor(.searchAccent, for: .normal)
        cancelButton.setTitleColor(highlighted, for: .highlighted)
        cancelButton.setTitleColor(highlighted, for: .selected)
        
        cancelButton.setTitle(.searchBarCancel, for: .normal)
        cancelButton.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
        addSubview(cancelButton)
    }
    
    @objc private func cancelButtonTapped() {
        textField.rightView?.isHidden = true
        delegate?.searchBarCancelButtonTapped(self)
    }
}

// MARK: UITextFieldDelegate & UITextInputDelegate

extension SearchBar: UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        delegate?.searchBarShouldBeginEditing(self) ?? true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        delegate?.searchBarSearchButtonTapped(self)
        return false
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        textField.text = ""
        textField.rightView?.isHidden = true
        delegate?.searchBar(self, textDidChange: "")
        return false
    }
    
    @objc private func textDidChange() {
        textField.rightView?.isHidden = textField.text?.count == 0
        delegate?.searchBar(self, textDidChange: textField.text ?? "")
    }
}
