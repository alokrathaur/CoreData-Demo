//
//  RegisterVC.swift
//  EducationDemo
//
//  Created by ALOK on 16/11/22.
//

import UIKit
import CoreData

class RegisterVC: UIViewController {

    @IBOutlet weak var txf_fname:UITextField!
    @IBOutlet weak var txf_lname:UITextField!
    @IBOutlet weak var txf_email:UITextField!
    @IBOutlet weak var txf_createPassword:UITextField!
    @IBOutlet weak var txf_confirmPassword:UITextField!
    
    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
      
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        // Do any additional setup after loading the view.
    }
    


}


extension RegisterVC{
 
    @IBAction func backClicked(_ sender:UIButton){
        
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func submitClick(_ sender:UIButton){
        
        if(validationCheck()){
            //do sign up
            registerUser()
        }
       
    }
        
    func registerUser(){
        let _:AppDelegate = (UIApplication.shared.delegate as! AppDelegate)
        let context:NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            let newUser = NSEntityDescription.insertNewObject(forEntityName: "Teacher", into: context) as NSManagedObject
        newUser.setValue(txf_fname.text, forKey: "fname")
        newUser.setValue(txf_lname.text, forKey: "lname")
        newUser.setValue(txf_email.text, forKey: "email")
        newUser.setValue(txf_createPassword.text, forKey: "password")
        do {
            try context.save()
        } catch {}
        print(newUser)
        print("Object Saved.")
        Util().showPopUpToast(message: "Registration Successful.", vc: self)
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    
    
    func validationCheck() -> Bool {
        
        if txf_fname.text?.count == 0{
            Util().showPopUpToast(message: "Enter first name.", vc: self)
            
            return false
        }else if txf_lname.text?.count == 0{
            Util().showPopUpToast(message: "Enter last name.", vc: self)
            
            return false
        }else if txf_email.text?.count == 0 {
            Util().showPopUpToast(message: "Enter email Id", vc: self)
            
            return false
        }
        else if (!(txf_email.text!.isValidEmailAddress())) {
            Util().showPopUpToast(message: "Please enter valid email id", vc: self)
            
            return false
        }else if txf_createPassword.text?.count == 0{
            Util().showPopUpToast(message: "Enter password", vc: self)
            
            return false
        }else if txf_createPassword.text!.count < 4{
            Util().showPopUpToast(message: "Password contains 4 characters with at least one uppercase, one lowercase, one digit and one special character.", vc: self)
            return false
        }else if (!(txf_createPassword.text!.isValidPassword())){
            Util().showPopUpToast(message: "Password contains 4 characters with at least one uppercase, one lowercase, one digit and one special character.", vc: self)
            
            return false
        }
        else if txf_confirmPassword.text?.count == 0{
            Util().showPopUpToast(message: "Enter confirm password.", vc: self)
            
            return false
        }else if txf_createPassword.text != txf_confirmPassword.text{
            Util().showPopUpToast(message: "Password and confirm password should be same.", vc: self)
            return false
        }
        return true
        
    }
    
}
