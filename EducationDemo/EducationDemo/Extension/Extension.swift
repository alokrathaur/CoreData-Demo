//
//  Extension.swift
//  EducationDemo
//
//  Created by ALOK on 16/11/22.
//

import Foundation
import UIKit

extension String {
    
    func isValidEmailAddress() -> Bool {
        
        // create a regex string...
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"

        // create predicate with format matching your regex string...
        let predicateTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return predicateTest.evaluate(with: self)
        
    }
    
    func isValidPassword() -> Bool {
        
        // if password is empty...
        if !self.isValidString() {
            return false
        }
        let regex = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[$@$!%*?&])[A-Za-z\\d$@$!%*?&]{4,}"; // with special characters
        
        //let regex2 = "(?=.*[A-Z])(?=.*[0-9])(?=.*[a-z]).{12,}" // no special characters
        
        // at least one uppercase -> at least one digit -> at least one lowercase -> 12 characters total
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", regex)
        return passwordTest.evaluate(with: self)
    }
    
    func isValidString() -> Bool {
        
        // string validation without space...
        let whitespace = CharacterSet.whitespacesAndNewlines
        if self.count == 0 || self.trimmingCharacters(in: whitespace).count == 0 {
            return false
        }
        return true
    }
    
}

@IBDesignable extension UIButton {

    @IBInspectable var borderWidth: CGFloat {
        set {
            layer.borderWidth = newValue
        }
        get {
            return layer.borderWidth
        }
    }

    @IBInspectable var cornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
        }
        get {
            return layer.cornerRadius
        }
    }

    @IBInspectable var borderColor: UIColor? {
        set {
            guard let uiColor = newValue else { return }
            layer.borderColor = uiColor.cgColor
        }
        get {
            guard let color = layer.borderColor else { return nil }
            return UIColor(cgColor: color)
        }
    }
}
