//
//  SearchBarTextField.swift
//  FlightSearch
//
//  Created by Андрей Овсянников on 28.11.2020.
//  Copyright © 2020 home.com. All rights reserved.
//

import UIKit

final class SearchBarTextField: UITextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureView() {
        let iconView = UIImageView(image: .search16)
        iconView.tintColor = .searchTint
        
        leftView = iconView
        leftViewMode = .always
        
        let clearButton = UIButton(type: .custom)
        clearButton.setImage(.clear16, for: .normal)
        clearButton.imageView?.tintColor = .searchClearTint
        clearButton.addTarget(self, action: #selector(textFieldDidClear), for: .touchUpInside)
        clearButton.isHidden = true
        
        rightView = clearButton
        rightViewMode = .whileEditing
        
        clearButtonMode = .never
    }
    
    @objc private func textFieldDidClear() {
        
        if delegate?.textFieldShouldClear?(self) == true {
            text = ""
        }
    }
    
    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        CGRect(x: 12, y: 10, width: 16, height: 16)
    }
    
    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        let buttonWidth: CGFloat = 12 * 2 + 16
        return CGRect(x: bounds.width - buttonWidth, y: 0, width: buttonWidth, height: bounds.height)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.placeholderRect(forBounds: bounds)
        return adjust(rect: rect, for: bounds)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.editingRect(forBounds: bounds)
        return adjust(rect: rect, for: bounds)
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.textRect(forBounds: bounds)
        return adjust(rect: rect, for: bounds)
    }
    
    private func adjust(rect: CGRect, for bounds: CGRect) -> CGRect {
        var rect = rect
        let leftRect = leftViewRect(forBounds: bounds)
        rect.origin.x = leftRect.maxX + 8
        rect.size.width -= 8
        return rect
    }
}
