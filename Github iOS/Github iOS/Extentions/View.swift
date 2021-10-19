//
//  View.swift
//  Github iOS
//
//  Created by Numan Ayhan on 19.10.2021.
//

import Foundation
import UIKit
import NVActivityIndicatorView
import TinyConstraints
let activityProgressView = UIActivityIndicatorView(style: .white)
var activityView: UIActivityIndicatorView?
var activityIndicator : NVActivityIndicatorView!
extension UIView {
    
    
    @objc   func anchor(top: NSLayoutYAxisAnchor?, left: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, right: NSLayoutXAxisAnchor?, paddingTop: CGFloat, paddingLeft: CGFloat, paddingBottom: CGFloat, paddingRight: CGFloat, width: CGFloat, height: CGFloat) {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            self.topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }
        
        if let left = left {
            self.leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
        }
        
        if let bottom = bottom {
            self.bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true
        }
        
        if let right = right {
            self.rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
        }
        
        if width != 0 {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        
        if height != 0 {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
    
    
    
    func centerInSuperview(size: CGSize = .zero) {
        translatesAutoresizingMaskIntoConstraints = false
        if let superviewCenterXAnchor = superview?.centerXAnchor {
            centerXAnchor.constraint(equalTo: superviewCenterXAnchor).isActive = true
        }
        
        if let superviewCenterYAnchor = superview?.centerYAnchor {
            centerYAnchor.constraint(equalTo: superviewCenterYAnchor).isActive = true
        }
        
        if size.width != 0 {
            widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }
        
        if size.height != 0 {
            heightAnchor.constraint(equalToConstant: size.height).isActive = true
        }
    }
    
    func startAnimate(){
        
        activityProgressView.color = UIColor.lightGray
        activityProgressView.startAnimating()
        self.addSubview(activityProgressView)
        activityProgressView.centerInSuperview()
       
        activityIndicator.height(45)
        activityIndicator.width(45)
        activityIndicator.startAnimating()
        
    }
    func stopAnimate(){
        activityIndicator.stopAnimating()
        activityIndicator.removeFromSuperview()
        
    }
    func showActivityIndicator() {
        self.translatesAutoresizingMaskIntoConstraints = false
        activityView = UIActivityIndicatorView(style: .gray)
        self.addSubview(activityView!)
        activityView?.centerInSuperview()
        
        activityView!.startAnimating()
    }

    func hideActivityIndicator(){
        if (activityView != nil){
            activityView?.stopAnimating()
        }
    }
    
}
 
