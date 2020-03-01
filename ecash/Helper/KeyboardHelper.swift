//
//  KeyboardHelper.swift
//  vietlifetravel
//
//  Created by Mac10 on 6/25/19.
//  Copyright © 2019 Mac10. All rights reserved.
//

import UIKit
class KeyboardHelper: NSObject{
  
  fileprivate var viewController: UIViewController?
  fileprivate var scrollView: UIScrollView?
  var delegate: KeyboardHelperDelegate?
  
  var touchGesture: UITapGestureRecognizer?
  var notTouchSubView : UIView?
  
  //Custom
  var keyboardAndEditingViewPadding = CGFloat(2) //Padding between keyboard and upview when move up
  var animationDuration = TimeInterval(0.5)
  
  fileprivate var yOriginalPos = CGFloat(0)
  
  //MARK: Constructors
  init(viewController: UIViewController?, scrollView: UIScrollView?) {
    self.viewController = viewController
    self.scrollView = scrollView
  }
  
  /**
   Set whether keyboard should be dismissed when we touch outside the editing text view
   */
  func setDismissKeyboardWhenTouchOutside(_ dismiss: Bool = true) {
    if dismiss {
      if let view = viewController?.view {
        if touchGesture == nil {
          touchGesture = UITapGestureRecognizer(target: self, action: #selector(self.dissmissKeyboard))
          touchGesture!.numberOfTapsRequired = 1
          touchGesture?.delegate = self
          view.addGestureRecognizer(touchGesture!)
        }
      }
    } else {
      if touchGesture != nil {
        viewController?.view?.removeGestureRecognizer(touchGesture!)
        touchGesture = nil
      }
    }
  }
  
  /**
   Dismiss keyboard
   */
  @objc fileprivate func dissmissKeyboard() {
    viewController?.view?.endEditing(true)
  }
  
  /**
   Register keyboard notification
   Should be invoked in viewDidAppear
   */
  func registerKeyboardNotification() {
    if viewController != nil {
      NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
      NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
  }
  
  /**
   Deregister keyboard notification
   Should be invoked in viewDidDisappear
   */
  func deregisterKeyboardNotification() {
    if viewController != nil {
      NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
      NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
  }
  
  //MARK: Keyboard event
  //Hanle when keyboard is visible
  @objc fileprivate func keyboardWillShow (_ notification: Notification)  {
    var info = notification.userInfo!
    let kbSize: CGSize = ((info["UIKeyboardFrameEndUserInfoKey"] as? CGRect)?.size)!
    print("kbSize = \(kbSize)")
    let contentInsets: UIEdgeInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: kbSize.height, right: 0.0)
    self.scrollView?.contentInset = contentInsets
    self.scrollView?.scrollIndicatorInsets = contentInsets
    var aRect: CGRect = CGRect()
    if let view = viewController?.view {
      aRect = view.frame
    }
    
    aRect.size.height -= kbSize.height
    viewController?.view.layoutIfNeeded()
//    if let active = activeField {
//      if !aRect.contains(active.frame.origin) {
//
//        self.scrollView.scrollRectToVisible(active.frame, animated: true)
//
//      }
//    }
  }
  
  //Hanle when keyboard is visible
  @objc fileprivate func keyboardWillHide (_ notification: Notification)  {
    //Get keyboard hidden duration
    let contentInsets: UIEdgeInsets = .zero
    self.scrollView?.contentInset = contentInsets
    self.scrollView?.scrollIndicatorInsets = contentInsets
  }
}
extension KeyboardHelper : UIGestureRecognizerDelegate {
  func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
    let touchPoint = gestureRecognizer.location(in: viewController?.view)
    if let notTouchView = notTouchSubView {
      let frame = notTouchView.convert(notTouchView.bounds, to: viewController?.view)
      if frame.contains(touchPoint) {
        return false
      }
    }
    return true
  }
}

//MARK: Define a protocol for KeyboardHelper
protocol KeyboardHelperDelegate {
  func detectEditingView() -> UIView?
}

