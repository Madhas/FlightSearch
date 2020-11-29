//
//  FlightCollectionCell.swift
//  FlightSearch
//
//  Created by Андрей Овсянников on 28.11.2020.
//  Copyright © 2020 home.com. All rights reserved.
//

import UIKit

class FlightCollectionCell: UICollectionViewCell {
    
    static private let titleHeight: CGFloat = 18
    static private let subtitleHeight: CGFloat = 16
    static private let interlabelSpace: CGFloat = 6
    
    var separatorEnabled = true {
        didSet {
            separator.isHidden = !separatorEnabled
        }
    }
    
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    private let iataLabel = UILabel()
    private let separator = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var isHighlighted: Bool {
        didSet {
            backgroundColor = isHighlighted ? .separator : .backgroundPrimary
        }
    }
    
    override var isSelected: Bool {
        didSet {
            backgroundColor = isSelected ? .separator : .backgroundPrimary
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        do {
            let size = iataLabel.sizeThatFits(CGSize(width: CGFloat.greatestFiniteMagnitude,
                                                     height: 22))
            let origin = CGPoint(x: bounds.width - 8 - size.width, y: bounds.midY - size.height / 2)
            iataLabel.frame = CGRect(origin: origin, size: size)
        }
        
        let width: CGFloat = iataLabel.frame.minX - 16 - 8
        
        let layoutHeight: CGFloat = FlightCollectionCell.titleHeight + (subtitleLabel.isHidden ? 0 : FlightCollectionCell.subtitleHeight + FlightCollectionCell.interlabelSpace)
        let titleY = bounds.midY - layoutHeight / 2
        
        titleLabel.frame = CGRect(x: 16,
                                  y: titleY,
                                  width: width,
                                  height: FlightCollectionCell.titleHeight)
        
        if !subtitleLabel.isHidden {
            subtitleLabel.frame = CGRect(x: 16,
                                         y: titleLabel.frame.maxY + FlightCollectionCell.interlabelSpace,
                                         width: width,
                                         height: FlightCollectionCell.subtitleHeight)
        }
        
        let pixel = 1 / UIScreen.main.scale
        separator.frame = CGRect(x: 16, y: bounds.height - pixel, width: bounds.width - 16, height: pixel)
    }
    
    func configure(with item: FlightCollectionItem) {
        titleLabel.text = item.title
        iataLabel.text = item.iata
        
        subtitleLabel.text = item.subtitle
        subtitleLabel.isHidden = item.subtitle == nil
    }
    
    private func configureView() {
        backgroundColor = .backgroundPrimary
        
        titleLabel.textColor = .textPrimary
        titleLabel.font = .systemFont(ofSize: 16)
        addSubview(titleLabel)
        
        subtitleLabel.textColor = .textSecondary
        subtitleLabel.font = .systemFont(ofSize: 14)
        addSubview(subtitleLabel)
        
        iataLabel.textColor = .searchAccent
        iataLabel.font = .systemFont(ofSize: 18, weight: .medium)
        iataLabel.textAlignment = .center
        addSubview(iataLabel)
        
        separator.backgroundColor = .separator
        separator.isHidden = !separatorEnabled
        addSubview(separator)
    }
}
