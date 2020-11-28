//
//  FlightCollectionCell.swift
//  FlightSearch
//
//  Created by Андрей Овсянников on 28.11.2020.
//  Copyright © 2020 home.com. All rights reserved.
//

import UIKit

class FlightCollectionCell: UICollectionViewCell {
    
    static private let titleHeight: CGFloat = 16
    static private let subtitleHeight: CGFloat = 13
    static private let interlabelSpace: CGFloat = 2
    
    let titleLabel = UILabel()
    let subtitleLabel = UILabel()
    let iataLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        do {
            let size = iataLabel.sizeThatFits(CGSize(width: CGFloat.greatestFiniteMagnitude,
                                                     height: 20))
            let origin = CGPoint(x: bounds.width - 8 - size.width, y: bounds.midY - size.height / 2)
            iataLabel.frame = CGRect(origin: origin, size: size)
        }
        
        let width: CGFloat = iataLabel.frame.minX - 8 * 2
        
        let layoutHeight: CGFloat = FlightCollectionCell.titleHeight + (subtitleLabel.isHidden ? FlightCollectionCell.subtitleHeight + FlightCollectionCell.interlabelSpace : 0)
        let titleY = bounds.midY - layoutHeight / 2
        
        titleLabel.frame = CGRect(x: 8,
                                  y: titleY,
                                  width: width,
                                  height: FlightCollectionCell.titleHeight)
        
        if !subtitleLabel.isHidden {
            subtitleLabel.frame = CGRect(x: 8,
                                         y: titleLabel.frame.maxY + FlightCollectionCell.interlabelSpace,
                                         width: width,
                                         height: FlightCollectionCell.subtitleHeight)
        }
    }
    
    func configure(with item: FlightCollectionItem) {
        titleLabel.text = item.title
        iataLabel.text = item.iata
        
        subtitleLabel.text = item.subtitle
        subtitleLabel.isHidden = item.subtitle == nil
    }
    
    private func configureView() {
        
    }
}
