//
//  UIView+Extensions.swift
//  hugoChallenge
//
//  Created by Vitor Spessoto on 24/04/21.
//

import UIKit

extension UIView {
    //*************************************************
    // MARK: - Public methods
    //*************************************************
    func pinEdges(to parent: UIView, synchronous: Bool = false) {
        let pin: () -> Void = {
            self.translatesAutoresizingMaskIntoConstraints = false
            self.leadingAnchor.constraint(equalTo: parent.leadingAnchor).isActive = true
            self.trailingAnchor.constraint(equalTo: parent.trailingAnchor).isActive = true
            self.topAnchor.constraint(equalTo: parent.topAnchor).isActive = true
            self.bottomAnchor.constraint(equalTo: parent.bottomAnchor).isActive = true
        }
        
        if synchronous {
            pin()
        } else {
            DispatchQueue.main.async(execute: pin)
        }
    }
    
    func anchor(top: NSLayoutYAxisAnchor?, left: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, rigth: NSLayoutXAxisAnchor?, paddingTop: CGFloat, paddingLeft: CGFloat, paddingBottom: CGFloat, paddingRigth: CGFloat, width: CGFloat, heigth: CGFloat, enableInsets: Bool) {
        
        let topInset = CGFloat()
        let bottomInset = CGFloat()
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            self.topAnchor.constraint(equalTo: top, constant: paddingTop + topInset).isActive = true
        }
        
        if let left = left {
            self.leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
        }
        
        if let rigth = rigth {
            self.rightAnchor.constraint(equalTo: rigth, constant: -paddingRigth).isActive = true
        }
        
        if let bottom = bottom {
            self.bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom - bottomInset).isActive = true
        }
        
        if heigth != 0 {
            heightAnchor.constraint(equalToConstant: heigth).isActive = true
        }
        
        if width != 0 {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
    }
}

