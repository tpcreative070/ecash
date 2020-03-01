//
//  ICNumericTextField.swift
//  ecash
//
//  Created by phong070 on 2/19/20.
//  Copyright © 2020 thanhphong070. All rights reserved.
//

import UIKit
class ICNumericTextField: UITextField {
    let numericKbdToolbar = UIToolbar()

    // MARK: Initilization
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initialize()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initialize()
    }

    // Sets up the input accessory view with a Done button that closes the keyboard
    func initialize()
    {
        self.keyboardType = UIKeyboardType.numberPad

        numericKbdToolbar.barStyle = UIBarStyle.default
        let space = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let callback = #selector(ICNumericTextField.finishedEditing)
        let donebutton = UIBarButtonItem(title:LanguageHelper.getTranslationByKey(LanguageKey.Done) ,style: UIBarButtonItem.Style.done, target: self, action: callback)
        numericKbdToolbar.setItems([space, donebutton], animated: false)
        numericKbdToolbar.sizeToFit()
        self.inputAccessoryView = numericKbdToolbar
    }

    // MARK: On Finished Editing Function
    @objc func finishedEditing()
    {
        self.resignFirstResponder()
    }
}
