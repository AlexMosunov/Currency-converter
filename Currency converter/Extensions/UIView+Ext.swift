//
//  UIView+Ext.swift
//  Currency converter
//
//  Created by Alex Mosunov on 15.10.2021.
//

import UIKit

fileprivate var activityIndicator: UIActivityIndicatorView?

extension UIView {
    
    func pin(to superView: UIView) {
        translatesAutoresizingMaskIntoConstraints                             = false
        topAnchor.constraint(equalTo: superView.topAnchor).isActive           = true
        leadingAnchor.constraint(equalTo: superView.leadingAnchor).isActive   = true
        trailingAnchor.constraint(equalTo: superView.trailingAnchor).isActive = true
        bottomAnchor.constraint(equalTo: superView.bottomAnchor).isActive     = true
    }
    
    
    func showActivityIndicator() {
        activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator?.center = self.center
        activityIndicator?.hidesWhenStopped = true
        activityIndicator?.startAnimating()
        self.addSubview(activityIndicator!)
    }
    
    func removeActivityIndicator() {
        activityIndicator?.stopAnimating()
        activityIndicator?.removeFromSuperview()
        activityIndicator = nil
    }
    
}
