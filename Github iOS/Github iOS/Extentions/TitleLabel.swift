//
//  TitleLabel.swift
//  Github iOS
//
//  Created by Numan Ayhan on 19.10.2021.
 
import Foundation
import UIKit

@IBDesignable class TitleLabel: UILabel {
    
    var title = UILabel()
    override var textColor: UIColor! {
        didSet {
            if !isFirstResponder {
                title.textColor = .black
            }
        }
    }
    @IBInspectable var topInset: CGFloat = 5.0
    @IBInspectable var bottomInset: CGFloat = 5.0
    @IBInspectable var leftInset: CGFloat = 5.0
    @IBInspectable var rightInset: CGFloat = 5.0
    
    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
        super.drawText(in: rect.inset(by: insets))
    }
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        self.commonInit()
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    func commonInit(){
        self.clipsToBounds = true
        
    }
    func setProperties(borderWidth: Float, borderColor: UIColor) {
        self.layer.borderWidth = CGFloat(borderWidth)
        self.layer.borderColor = borderColor.cgColor
    }
    override var intrinsicContentSize: CGSize {
            let size = super.intrinsicContentSize
            return CGSize(width: size.width + leftInset + rightInset,
                          height: size.height + topInset + bottomInset)
        }
}
