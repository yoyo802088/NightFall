//
//  Utilities.swift
//  customauth
//
//  Created by Christopher Ching on 2019-05-09.
//  Copyright © 2019 Christopher Ching. All rights reserved.
//

import Foundation
import UIKit

class Utilities {
    
    
    static func styleTextUnderlineField(_ textfield:UITextField) {
        // Create the bottom line
        let bottomLine = CALayer()
        
        bottomLine.frame = CGRect(x: 0, y: textfield.frame.height-9, width: textfield.frame.width, height: 1)
        
        bottomLine.backgroundColor = UIColor.init(white: 0.7, alpha: 1).cgColor
        
        // Remove border on text field
        textfield.borderStyle = .none
        
        // Add the line to the text field
        textfield.layer.addSublayer(bottomLine)
    }
    
    static func styleTextField(_ textfield:UILabel) {

        textfield.textColor = UIColor(red: 0.921, green: 0.921, blue: 0.921, alpha: 1)
    
    }
    
    static func styleFilledButton_1(_ button:UIButton) {

        button.frame = CGRect(x: 0, y: 0, width: 170, height: 40)
        button.backgroundColor = .white
        button.layer.backgroundColor = UIColor(red: 0.929, green: 0.294, blue: 0.282, alpha: 1).cgColor
        button.layer.cornerRadius = 5

    }
    static func styleFilledButton_2(_ button:UIButton) {

            button.backgroundColor = .white
            button.layer.backgroundColor = UIColor(red: 0.317, green: 0.305, blue: 0.379, alpha: 1).cgColor
            button.layer.cornerRadius = 5

        }
    static func styleFilledButton_3(_ button:UIButton) {
            
            button.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
            button.layer.cornerRadius = 5
            button.layer.borderWidth = 1
            button.layer.borderColor = UIColor(red: 0.557, green: 0.545, blue: 0.608, alpha: 1).cgColor

        }
    
    static func styleHollowButton(_ button:UIButton) {
        
        // Hollow rounded corner style
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.cornerRadius = 25.0
        button.tintColor = UIColor.black
    }
    
    static func isPasswordValid(_ password : String) -> Bool {
        let regEx = "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}"
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", regEx)
        return passwordTest.evaluate(with: password)
    }
    
    static func isValidEduEmail(_ email: String) -> Bool {
        let regEx = "^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.+-]+\\.edu$"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", regEx)
        return emailPred.evaluate(with: email)
    }
    
}
