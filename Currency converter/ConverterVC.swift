//
//  ConverterVC.swift
//  Currency converter
//
//  Created by Alex Mosunov on 31.08.2021.
//

import UIKit

class ConverterVC: UIViewController {
    
    let numberTextField = CCNumberTextField()
    let callToActionButton = CCButton(bgColor: UIColor.systemRed , title: "GET BITCOINS")

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemRed
    }
    


}
