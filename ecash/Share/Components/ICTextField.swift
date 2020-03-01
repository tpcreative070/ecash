//
//  VNTextField.swift
//  vietlifetravel
//
//  Created by Mac10 on 6/25/19.
//  Copyright © 2019 Mac10. All rights reserved.
//

import UIKit
@IBDesignable
class ICTextField: UIView {
  lazy var inputField: TextField = {
    let inputField = TextField()
    inputField.font = AppFonts.moderateScale(fontName: AppFonts.SFranciscoRegular, size: AppFonts.TEXTFIELD_TITLE_FONT_SIZE)
    inputField.translatesAutoresizingMaskIntoConstraints = true
    inputField.textColor = AppColors.GRAY_COLOR
    inputField.autocapitalizationType = .none
    inputField.autocorrectionType = .no
    return inputField
  }()
  
  lazy var floatLabel: UILabel = {
    let floatLabel = UILabel()
    floatLabel.font = AppFonts.moderateScale(fontName: AppFonts.SFranciscoRegular, size: AppFonts.TEXTFIELD_TITLE_FONT_SIZE)
    floatLabel.textAlignment = .left
    floatLabel.translatesAutoresizingMaskIntoConstraints = true
    floatLabel.textColor = AppColors.BLACK_COLOR
    return floatLabel
  }()
  
  lazy var errorLabel: UILabel = {
    let errorLabel = UILabel()
    errorLabel.textColor = AppColors.RED_COLOR
    errorLabel.text = ""
    errorLabel.textAlignment = .left
    errorLabel.translatesAutoresizingMaskIntoConstraints = true
    errorLabel.lineBreakMode = .byWordWrapping
    errorLabel.numberOfLines = 0
    errorLabel.font = AppFonts.moderateScale(fontName: AppFonts.SFranciscoRegular, size: AppFonts.TEXTFIELD_TITLE_FONT_SIZE)
    return errorLabel
  }()
  
  lazy var headerView: UIView = {
    let headerView = UIView()
    headerView.translatesAutoresizingMaskIntoConstraints = true
    return headerView
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupView()
    self.translatesAutoresizingMaskIntoConstraints = true
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setupView()
  }
  
  private func setupView() {
    backgroundColor = .white
    setupLayout()
  }
  
  open func changeToFloat(animated: Bool) {
    let animationDuration = 0.2
    CATransaction.begin()
    CATransaction.setAnimationDuration(animationDuration)
    CATransaction.setAnimationTimingFunction(CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut))
    CATransaction.commit()
    UIView.animate(withDuration: animationDuration, delay: 0.0, options: .curveEaseOut
      , animations: {
        self.floatLabel.alpha = 1.0
        self.floatLabel.text = self.inputField.placeholder
    }
      , completion: {
        _ in
        
    })
  }
  
  open func changeToIdle(animated: Bool) {
    let animationDuration = 0.2
    CATransaction.begin()
    CATransaction.setAnimationDuration(animationDuration)
    CATransaction.setAnimationTimingFunction(CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut))
    CATransaction.commit()
    UIView.animate(withDuration: animationDuration, delay: 0.0, options: .curveEaseOut
      , animations: {
        self.floatLabel.alpha = 0.0
        self.floatLabel.text = ""
    }
      , completion: {
        _ in
    })
  }
  
  @objc open func editingChanged() {
    if let text = inputField.text, text.count > 0 {
      self.changeToFloat(animated: true)
    } else {
      self.changeToIdle(animated: true)
    }
  }
  
  func setText(_ text : String?){
    inputField.text = text
  }
  
  private func setupLayout() {
    // setup float label
    addSubview(floatLabel)
    NSLayoutConstraint.activate([
      floatLabel.topAnchor.constraint(equalTo: topAnchor),
      floatLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: AppConstants.FLOAT_LABEL_MARGIN_LEFT),
      floatLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
      floatLabel.heightAnchor.constraint(equalToConstant: AppConstants.FLOAT_LABEL_HEIGHT)
      ])
    self.floatLabel.alpha = 0.0
    
    // setup input field
    addSubview(inputField)
    NSLayoutConstraint.activate([
      inputField.topAnchor.constraint(equalTo: floatLabel.bottomAnchor),
      inputField.leadingAnchor.constraint(equalTo: leadingAnchor),
      inputField.trailingAnchor.constraint(equalTo: trailingAnchor),
      inputField.heightAnchor.constraint(equalToConstant: AppConstants.INPUT_FIELD_HEIGHT)
      ])
    Helper.addLineToView(view: inputField, position:.LINE_POSITION_BOTTOM, color: AppColors.TEXTFIELD_BORDER, width: 0.5)
    
    // setup error label
    addSubview(errorLabel)
    NSLayoutConstraint.activate([
      errorLabel.topAnchor.constraint(equalTo: inputField.bottomAnchor),
      errorLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
      errorLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
      errorLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
      ])
    inputField.addTarget(self, action: #selector(editingChanged), for: .allEvents)
  }
  
  //custom views should override this to return true if
  //they cannot layout correctly using autoresizing.
  //from apple docs https://developer.apple.com/documentation/uikit/uiview/1622549-requiresconstraintbasedlayout
  override class var requiresConstraintBasedLayout: Bool {
    return true
  }
}
