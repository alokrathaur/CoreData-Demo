//
//  LoginVC.swift
//  EducationDemo
//
//  Created by ALOK on 16/11/22.
//

import UIKit
import CoreData

class LoginVC: UIViewController {
    
    @IBOutlet weak var txt_email:UITextField!
    @IBOutlet weak var txt_pass:UITextField!
    
    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
     
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
    }
    
   
}

extension LoginVC{
 
    @IBAction func backClicked(_ sender:UIButton){
        
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func forgotClicked(_ sender:UIButton){
 
    }
    
    @IBAction func registerClicked(_:UIButton){
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "RegisterVC") as! RegisterVC
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @IBAction func submitClick(_ sender:UIButton){
        
        if txt_email.text?.count == 0 {
            Util().showPopUpToast(message: "Enter email Id", vc: self)
            
            return
        }
        if (!(txt_email.text!.isValidEmailAddress())) {
            Util().showPopUpToast(message: "Please enter valid email id", vc: self)
            
             return
        }else if txt_pass.text?.count == 0{
            Util().showPopUpToast(message: "Enter password", vc: self)
            
            return
        }
        checkLogin()
        
    }
    
}

extension LoginVC{
    
    //MARK:- API's

    func checkLogin(){
    
    let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Teacher")
    let searchString = self.txt_email.text
    let searcghstring2 = self.txt_pass.text
    request.predicate = NSPredicate (format: "email == %@", searchString!)
    do
    {
        let result = try context.fetch(request)
        if result.count > 0
        {
            let   n = (result[0] as AnyObject).value(forKey: "email") as! String
            let p = (result[0] as AnyObject).value(forKey: "password") as! String
            //  print(" checking")


            if (searchString == n && searcghstring2 == p)
            {
               // move to dashboard
                //StudentListViewController
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "StudentListViewController") as! StudentListViewController
                self.navigationController?.pushViewController(vc, animated: true)
//                let vc = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
//                vc.myStringValue = txt_email.text;
//                self.navigationController?.pushViewController(vc, animated: true)
//
            }
            else if (searchString == n || searcghstring2 == p)
            {
                // print("password incorrect ")
                let alertController1 = UIAlertController (title: "No user found ", message: "Password incorrect ", preferredStyle: UIAlertController.Style.alert)
                alertController1.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                present(alertController1, animated: true, completion: nil)
            }
        }
        else
        {
            let alertController1 = UIAlertController (title: "No user found ", message: "Invalid email ID ", preferredStyle: UIAlertController.Style.alert)
            alertController1.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alertController1, animated: true, completion: nil)
            print("no user found")
        }
    }
    catch
    {
        print("error")
    }
}
    
    
    func saveDB(){
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Teacher")
       let emailString = self.txt_email.text
       let pwdString = self.txt_pass.text
       request.predicate = NSPredicate (format: "name == %@", emailString!)
        
    }
    
}

