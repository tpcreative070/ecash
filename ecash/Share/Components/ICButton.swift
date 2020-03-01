//
//  ICButton.swift
//  vietlifetravel
//
//  Created by Mac10 on 6/26/19.
//  Copyright © 2019 Mac10. All rights reserved.
//

import UIKit
@IBDesignable
class ICButton : UIButton{
    let gradientLayer = CAGradientLayer()
    
    var activityIndicator: UIActivityIndicatorView!
    var originalButtonText: String?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    func setupView() {
        self.layer.backgroundColor = UIColor.clear.cgColor
        self.setTitleColor(.black, for: .normal)
        self.titleLabel?.font = AppFonts.moderateScale(fontName: AppFonts.SFranciscoRegular, size: AppFonts.BUTTON_TITLE_SIZE)
        self.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    @IBInspectable
    var topGradientColor: UIColor? {
        didSet {
            setGradient(topGradientColor: topGradientColor, bottomGradientColor: bottomGradientColor)
        }
    }
    
    @IBInspectable
    var bottomGradientColor: UIColor? {
        didSet {
            setGradient(topGradientColor: topGradientColor, bottomGradientColor: bottomGradientColor)
        }
    }
    
    private func setGradient(topGradientColor: UIColor?, bottomGradientColor: UIColor?) {
        if let topGradientColor = topGradientColor, let bottomGradientColor = bottomGradientColor {
            gradientLayer.frame = bounds
            gradientLayer.colors = [topGradientColor.cgColor, bottomGradientColor.cgColor]
            gradientLayer.borderColor = layer.borderColor
            gradientLayer.borderWidth = layer.borderWidth
            gradientLayer.cornerRadius = layer.cornerRadius
            layer.insertSublayer(gradientLayer, at: 0)
        } else {
            gradientLayer.removeFromSuperlayer()
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat = 0.0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
            self.clipsToBounds = true
        }
    }
    
    override public func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: layer)
        gradientLayer.frame = bounds
    }
    
    func showLoading() {
        originalButtonText = self.titleLabel?.text
        self.setTitle("", for: .normal)

        if (activityIndicator == nil) {
            activityIndicator = createActivityIndicator()
        }
        showSpinning()
    }

    func hideLoading() {
        self.setTitle(originalButtonText, for: .normal)
        if (activityIndicator != nil) {
            activityIndicator.stopAnimating()
        }
    }
    
    func enableTouch() {
        self.isEnabled = true
        self.bottomGradientColor = AppColors.BLUE
        self.topGradientColor = AppColors.BLUE
        self.alpha = AppConstants.ALPHA_DEFAULT
    }
    
    func enableTouch(backgroudColor: UIColor, alpha: CGFloat) {
        self.isEnabled = true
        self.bottomGradientColor = backgroudColor
        self.topGradientColor = backgroudColor
        self.alpha = alpha
    }
    
    func disableTouch() {
        self.isEnabled = false
        self.bottomGradientColor = AppColors.BLUE
        self.topGradientColor = AppColors.BLUE
        self.alpha = AppConstants.ALPHA_DISBALE
    }
    
    func disableTouch(backgroudColor: UIColor, alpha: CGFloat) {
        self.isEnabled = false
        self.bottomGradientColor = backgroudColor
        self.topGradientColor = backgroudColor
        self.alpha = alpha
    }
    
    private func createActivityIndicator() -> UIActivityIndicatorView {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = .white
        return activityIndicator
    }

    private func showSpinning() {
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(activityIndicator)
        centerActivityIndicatorInButton()
        activityIndicator.startAnimating()
    }

    private func centerActivityIndicatorInButton() {
        let xCenterConstraint = NSLayoutConstraint(item: self, attribute: .centerX, relatedBy: .equal, toItem: activityIndicator, attribute: .centerX, multiplier: 1, constant: 0)
        self.addConstraint(xCenterConstraint)

        let yCenterConstraint = NSLayoutConstraint(item: self, attribute: .centerY, relatedBy: .equal, toItem: activityIndicator, attribute: .centerY, multiplier: 1, constant: 0)
        self.addConstraint(yCenterConstraint)
    }
    
}
