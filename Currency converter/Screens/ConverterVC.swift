//
//  ConverterVC.swift
//  Currency converter
//
//  Created by Alex Mosunov on 31.08.2021.
//

import UIKit

class ConverterVC: UIViewController {
    
    //MARK: Elements
    
    private let numberTextField = CCNumberTextField()
    private let resultLabel = CCResultLabel()
//    private let callToActionButton = CCButton(bgColor: UIColor.systemRed , title: "GET BITCOINS")
    private let stackView = UIStackView()
    private let pickerView = UIPickerView()
    private let activityIndicator = UIActivityIndicatorView(style: .large)
    
    //MARK: Properties
    
    private var baseNumber = 100
    private var filteredBaseCurrenciesArray = [String]()
    private var filteredCurrenciesArray = [String]()
    private var baseCurrency = Currency.usd
    private var currency = Currency.uah
    private let converter = ConverterModel.shared
    
    private var numberTextFieldTopConstraint: NSLayoutConstraint?
    private var resultLabelTopConstraint: NSLayoutConstraint?
    private var stackViewTopConstraint: NSLayoutConstraint?
    
    // MARK: init/deinit
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        createDismissKeyboardTapGesture()
        configureResultLabel()
        configureNumberTF()
        configureStackView()
        configureActivityIndicator()
        fetchDataWithAlamofire()
        
        showSplashScreen()
//        print("978".toCurrencyCode)

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    
    //MARK: Notification Handlers
    
    @objc func keyboardWillShow(_ notification: NSNotification) {
        resetTopConstraintsFor(resultLabelTopConstant: 50,
                               numberTextFieldConstant: 50,
                               stackViewTopConstant: 0,
                               animateWithDuration: 2000)
    }
    
    @objc func keyboardWillHide(_ notification: NSNotification) {
        resetTopConstraintsFor(resultLabelTopConstant: 150,
                               numberTextFieldConstant: 125,
                               stackViewTopConstant: 30,
                               animateWithDuration: 2000)
    }
    
    
    // MARK: Fetching data
    
    func fetchDataWithAlamofire() {
        let countryList = Locale.isoRegionCodes.compactMap { Locale.current.localizedString(forRegionCode: $0) }
        print(countryList)
        activityIndicator.startAnimating()
        AlamofireNetworkRequest.sendRequest(url: "\(Constants.PrivatBank.getBaseCurrencyExchanges)", apiType: .privatBank) { [self] (currencyPairs) in
            guard let currencyPairs = currencyPairs as? [CurrencyPairPrivatbank] else { return }
            
            // getting available currencies from API
            var currenciesArray = [String]()
            for pair in currencyPairs {
//                guard let pair = pair as? CurrencyPairPrivatbank else { return }
                if let base_ccy = pair.base_ccy, currenciesArray.contains(base_ccy) == false {
                    currenciesArray.append(base_ccy)
                }

                if let ccy = pair.ccy, currenciesArray.contains(ccy) == false {
                    currenciesArray.append(ccy)
                }
            }
            
            // filtering result from api to supported currencies
            self.filteredBaseCurrenciesArray = currenciesArray.filter { Currency.allCasesStringsArray.contains($0) }
            
            self.filteredCurrenciesArray = filteredBaseCurrenciesArray
            
            // putting usd on the first place of array
            for i in 0...self.filteredCurrenciesArray.count - 1 {
                if self.filteredCurrenciesArray[i] == currency.rawValue {
                    let usd = self.filteredCurrenciesArray.remove(at: i)
                    self.filteredCurrenciesArray.insert(usd, at: 0)
                }
            }
            
            // putting uah on the first place of base array
            for i in 0...self.filteredBaseCurrenciesArray.count - 1 {
                if self.filteredBaseCurrenciesArray[i] == baseCurrency.rawValue {
                    let usd = self.filteredBaseCurrenciesArray.remove(at: i)
                    self.filteredBaseCurrenciesArray.insert(usd, at: 0)
                }
            }
            
            // setting first and last element for start
//            self.baseCurrency = Currency.getCurrency(firstBaseCurrency)
//            self.currency = Currency.getCurrency(firstCurrency)
            
            // calculating rates for all possible currency pairs
            self.converter.calcData(currencyPairs)
            self.setResultLabelText(num: Float(baseNumber))
            self.numberTextField.text = "\(baseNumber)"

            // reloading UI
            DispatchQueue.main.async {
                self.pickerView.reloadAllComponents()
                self.activityIndicator.stopAnimating()
            }
        }
    }
    
    private func setResultLabelText(num: Float) {
        guard let mult = converter.getCurrencyCourse(baseCurrency: baseCurrency, currency: currency) else {
            resultLabel.text = "no data"
            return
        }
        resultLabel.text = String(round(100 * num * mult) / 100)
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
        filteredBaseCurrenciesArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return filteredBaseCurrenciesArray[row]
        } else {
            return filteredCurrenciesArray[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0 {
            if let baseCurrency = Currency.getCurrency(filteredBaseCurrenciesArray[row]) {
                self.baseCurrency = baseCurrency
            }
        } else {
            if let currency = Currency.getCurrency(filteredCurrenciesArray[row]) {
                self.currency = currency
            }
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
        
        resultLabelTopConstraint = NSLayoutConstraint(item: resultLabel, attribute: .topMargin, relatedBy: .equal, toItem: self.view, attribute: .topMargin, multiplier: 1.0, constant: 150)
        resultLabelTopConstraint?.priority = UILayoutPriority(500)
        resultLabelTopConstraint?.isActive = true
        
        NSLayoutConstraint.activate([
//            resultLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
            resultLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            resultLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            resultLabel.heightAnchor.constraint(equalToConstant: 150)
        ])
    }
    
    private func configureNumberTF() {
        view.addSubview(numberTextField)
        numberTextField.delegate = self
        numberTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        
        numberTextFieldTopConstraint = NSLayoutConstraint(item: numberTextField, attribute: .topMargin, relatedBy: .equal, toItem: resultLabel, attribute: .bottomMargin, multiplier: 1.0, constant: 125)
        numberTextFieldTopConstraint?.priority = UILayoutPriority(500)
        numberTextFieldTopConstraint?.isActive = true
        
        NSLayoutConstraint.activate([
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
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        stackViewTopConstraint = NSLayoutConstraint(item: stackView, attribute: .topMargin, relatedBy: .equal, toItem: numberTextField, attribute: .bottom, multiplier: 1.0, constant: 30)
        stackViewTopConstraint?.isActive = true
        
        NSLayoutConstraint.activate([
//            stackView.topAnchor.constraint(equalTo: numberTextField.bottomAnchor, constant: 30),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            stackView.bottomAnchor.constraint(lessThanOrEqualTo: view.bottomAnchor, constant: -75),
            stackView.heightAnchor.constraint(equalToConstant: 150)
        ])
    }
    
    private func configureActivityIndicator() {
        view.addSubview(activityIndicator)
        activityIndicator.center = view.center
        activityIndicator.color = .brown
    }
    
    private func resetTopConstraintsFor(resultLabelTopConstant: CGFloat,
                                        numberTextFieldConstant: CGFloat,
                                        stackViewTopConstant: CGFloat,
                                        animateWithDuration: TimeInterval) {
        resultLabelTopConstraint?.isActive = false
        numberTextFieldTopConstraint?.isActive = false
        stackViewTopConstraint?.isActive = false
        
        resultLabelTopConstraint = NSLayoutConstraint(item: resultLabel, attribute: .topMargin, relatedBy: .equal, toItem: self.view, attribute: .topMargin, multiplier: 1.0, constant: resultLabelTopConstant)
        numberTextFieldTopConstraint = NSLayoutConstraint(item: numberTextField, attribute: .topMargin, relatedBy: .equal, toItem: resultLabel, attribute: .bottomMargin, multiplier: 1.0, constant: numberTextFieldConstant)
        stackViewTopConstraint = NSLayoutConstraint(item: stackView, attribute: .topMargin, relatedBy: .equal, toItem: numberTextField, attribute: .bottomMargin, multiplier: 1.0, constant: stackViewTopConstant)
        resultLabelTopConstraint?.priority = UILayoutPriority(500)
        numberTextFieldTopConstraint?.priority = UILayoutPriority(500)
        
        resultLabelTopConstraint?.isActive = true
        numberTextFieldTopConstraint?.isActive = true
        stackViewTopConstraint?.isActive = true
        
        UIView.animate(withDuration: animateWithDuration, animations:{
            self.view.layoutIfNeeded()
        })
    }
    
    private func showSplashScreen() {
        let splashScreenView = UIView(frame: self.view.bounds)
        let splashImage = UIImageView(frame: self.view.bounds)
        splashImage.image = UIImage(named: "launchScreen")
        splashImage.contentMode = .scaleAspectFill
        splashScreenView.addSubview(splashImage)
        self.view.addSubview(splashScreenView)
        
        Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false) { timer in
            UIView.animate(withDuration: 1) {
                splashScreenView.alpha = 0.0
            } completion: { bool in
                splashScreenView.removeFromSuperview()
            }
        }
        
    }
    
}
