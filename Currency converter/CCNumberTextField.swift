//
//  ConverterTextField.swift
//  Currency converter
//
//  Created by Alex Mosunov on 07.09.2021.
//

import UIKit

class CCNumberTextField: UITextField {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        
        keyboardType = .numbersAndPunctuation
        
        layer.cornerRadius = 10
        layer.borderWidth = 2
        layer.borderColor = UIColor.systemGray4.cgColor
        
        textColor = .label
        tintColor = .label
        textAlignment = .left
        font = UIFont.preferredFont(forTextStyle: .title2)
        
        backgroundColor = .tertiarySystemBackground
        
    }
    
}