//
//  ConverterVC.swift
//  Currency converter
//
//  Created by Alex Mosunov on 31.08.2021.
//

import UIKit

class ConverterVC: UIViewController {
    
    private let numberTextField = CCNumberTextField()
    private let resultLabel = CCResultLabel()
    private let callToActionButton = CCButton(bgColor: UIColor.systemRed , title: "GET BITCOINS")

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureResultLabel()
        configureNumberTF()
    }

    
    private func configureResultLabel() {
        view.addSubview(resultLabel)
        
        NSLayoutConstraint.activate([
            resultLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
            resultLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            resultLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            resultLabel.heightAnchor.constraint(equalToConstant: 150)
        ])
        
        
    }
    
    
    private func configureNumberTF() {
        view.addSubview(numberTextField)
        
        NSLayoutConstraint.activate([
            numberTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            numberTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            numberTextField.heightAnchor.constraint(equalToConstant: 40),
            numberTextField.widthAnchor.constraint(equalToConstant: 200)
        ])
    }
    
}
