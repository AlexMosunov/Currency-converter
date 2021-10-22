//
//  CCResultLabel.swift
//  Currency converter
//
//  Created by Alex Mosunov on 07.09.2021.
//

import UIKit

class CCResultLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        text = "0.0"
//        backgroundColor = .systemGray2
        backgroundColor = .systemTeal
        textAlignment = .center
        numberOfLines = 1
        
        font = UIFont.boldSystemFont(ofSize: 52)
        textColor = .systemBackground
        
        layer.masksToBounds = true
        layer.cornerRadius = 10
        
        translatesAutoresizingMaskIntoConstraints = false
    }
}
