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
    
    static func styleTextField(_ textfield:UILabel) {

        textfield.textColor = UIColor(red: 0.921, green: 0.921, blue: 0.921, alpha: 1)
        // Create the bottom line
//        let bottomLine = CALayer()
//
//        bottomLine.frame = CGRect(x: 0, y: textfield.frame.height-9, width: textfield.frame.width, height: 1)
//
//        bottomLine.backgroundColor = UIColor.init(white: 0.7, alpha: 1).cgColor
//
//        // Remove border on text field
//        textfield.borderStyle = .none
//
//        // Add the line to the text field
//        textfield.layer.addSublayer(bottomLine)
        
    }
    
    static func styleFilledButton(_ button:UIButton) {
        
        // Filled rounded corner style

        button.frame = CGRect(x: 0, y: 0, width: 170, height: 40)
        button.backgroundColor = .white
        button.layer.backgroundColor = UIColor(red: 0.929, green: 0.294, blue: 0.282, alpha: 1).cgColor
        button.layer.cornerRadius = 5

//        button.backgroundColor = UIColor.init(red: 48/255, green: 173/255, blue: 99/255, alpha: 1)
//        button.layer.cornerRadius = 25.0
//        button.tintColor = UIColor.white
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
