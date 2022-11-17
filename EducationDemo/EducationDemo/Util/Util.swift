//
//  Util.swift
//  EducationDemo
//
//  Created by ALOK on 16/11/22.
//

import Foundation
import UIKit

class Util {

    func showPopUpToast(message : String, vc: UIViewController){
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.view.layer.cornerRadius = 15
        
        vc.present(alert, animated: true)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
            alert.dismiss(animated: true)
        }
        
    }
}
