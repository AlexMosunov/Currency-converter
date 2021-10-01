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
        keyboardType                              = .decimalPad
        returnKeyType                             = .done
        layer.cornerRadius                        = 10
        layer.borderWidth                         = 2
        layer.borderColor                         = UIColor.systemGray4.cgColor
        textColor                                 = .label
        tintColor                                 = .label
        textAlignment                             = .center
        font                                      = UIFont.preferredFont(forTextStyle: .title2)
        backgroundColor                           = .tertiarySystemBackground
        addDoneButtonOnKeyboard()
    }
    
    func addDoneButtonOnKeyboard() {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 30))
        doneToolbar.barStyle = .default
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneButtonAction))
        
        let items = [flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        self.inputAccessoryView = doneToolbar
    }
    
    @objc func doneButtonAction() {
        self.resignFirstResponder()
    }
}
