//
//  InfoView.swift
//  FlightSearch
//
//  Created by Андрей Овсянников on 18.02.2021.
//  Copyright © 2021 home.com. All rights reserved.
//

import UIKit

final class InfoView: UIView {

    let label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .backgroundPrimary
        
        addSubview(label)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        label.frame = bounds
    }
}
