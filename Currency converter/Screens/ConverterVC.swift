//
//  ConverterVC.swift
//  Currency converter
//
//  Created by Alex Mosunov on 31.08.2021.
//

import UIKit

class ConverterVC: UIViewController {
    
    private let monobankURL = "https://api.monobank.ua/bank/currency"
    private let privatbankURL = "https://api.privatbank.ua/p24api/pubinfo?json&exchange&coursid=5"
    
    private let numberTextField = CCNumberTextField()
    private let resultLabel = CCResultLabel()
    private let callToActionButton = CCButton(bgColor: UIColor.systemRed , title: "GET BITCOINS")
    private let stackView = UIStackView()
    private let pickerView = UIPickerView()
    private let activityIndicator = UIActivityIndicatorView(style: .large)
    
    private var currenciesArray = [String]()
    
    private var baseCurrency: Currency?
    private var currency: Currency?
    
    private let converter = ConverterModel.shared
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
    
        
//        fetchDataWithAlamofire()
        createDismissKeyboardTapGesture()
        configureResultLabel()
        configureNumberTF()
        configureStackView()
        configureActivityIndicator()
        fetchDataWithAlamofire()
        
    }
    
    func fetchDataWithAlamofire() {
        activityIndicator.startAnimating()
        AlamofireNetworkRequest.sendRequest(url: privatbankURL) { (currencyPairs) in
            print(currencyPairs)

//            var currencyNamesArray = [String]()
            for pair in currencyPairs {
                if let base_ccy = pair.base_ccy, self.currenciesArray.contains(base_ccy) == false {
                    self.currenciesArray.append(base_ccy)
                }

                if let ccy = pair.ccy, self.currenciesArray.contains(ccy) == false {
                    self.currenciesArray.append(ccy)
                }
            }
            
            if let firstElement = self.currenciesArray.first {
                self.baseCurrency = Currency.getCurrency(firstElement)
                self.currency = Currency.getCurrency(firstElement)
            }
            
            self.converter.calcData(currencyPairs)
            self.setResultLabelText(num: 100)
            self.numberTextField.text = "100"
            
            DispatchQueue.main.async {
                self.pickerView.reloadAllComponents()
                self.activityIndicator.stopAnimating()
            }
        }
    }
    
    
    private func setResultLabelText(num: Float) {
        
        if baseCurrency != nil && currency != nil {
            guard let mult = converter.getCurrencyCourse(baseCurrency: baseCurrency!, currency: currency!) else {
                resultLabel.text = "no data"
                return
            }
            resultLabel.text = String(round(100 * num * mult) / 100)
        } else {
            resultLabel.text = "0.0"
        }
    }
}

//MARK: - UITextFieldDelegate

extension ConverterVC: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
    
    @objc func textFieldDidChange() {
        guard let text = numberTextField.text else { return }
        if text.isEmpty {
            resultLabel.text = "0.0"
        } else if let num = Float(text) {
            setResultLabelText(num: num)
        }
    }
    
}


//MARK: - UIPickerViewDelegate, UIPickerViewDataSource

extension ConverterVC: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        currenciesArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//        if component == 0 {
            return currenciesArray[row]
//        } else {
//            return currenciesArray.reversed()[row]
//        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0 {
            baseCurrency = Currency.getCurrency(currenciesArray[row])
        } else {
            currency = Currency.getCurrency(currenciesArray[row])
        }
        

            if let text = numberTextField.text , let num = Float(text) {
                setResultLabelText(num: num)
            }

    }
    

}

//MARK: - Configure funcs

extension ConverterVC {
    private func createDismissKeyboardTapGesture() {
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
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
        numberTextField.delegate = self
        numberTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        
        NSLayoutConstraint.activate([
            numberTextField.topAnchor.constraint(equalTo: resultLabel.bottomAnchor, constant: 125),
            numberTextField.heightAnchor.constraint(equalToConstant: 45),
            numberTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            numberTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50)
        ])
    }
    
    private func configurePickerView() -> UIPickerView {
//        view.addSubview(pickerView)
        pickerView.delegate = self
        pickerView.dataSource = self
//        pickerView.translatesAutoresizingMaskIntoConstraints = false
//        pickerView.layer.borderColor = UIColor.black.cgColor
//        pickerView.layer.borderWidth = 1.5
//        pickerView.frame.width = numberTextField.frame.width
//        pickerView.frame = CGRect(x: 0, y: 0, width: numberTextField.frame.width, height: 150)
//        pickerView.backgroundColor = .blue
//        pickerView.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            pickerView.topAnchor.constraint(equalTo: numberTextField.bottomAnchor, constant: 30),
//            pickerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
//            pickerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
//            pickerView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50)
//        ])
        return pickerView
    }
    
    private func configureStackView() {
        view.addSubview(stackView)
        stackView.addArrangedSubview(configurePickerView())
//        stackView.addSubview(configurePickerView())
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 10
//        stackView.backgroundColor = .red
        
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: numberTextField.bottomAnchor, constant: 30),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -150)
        ])
    }
    
    private func configureActivityIndicator() {
        view.addSubview(activityIndicator)
        activityIndicator.center = view.center
        activityIndicator.color = .brown
    }

    
    
}
