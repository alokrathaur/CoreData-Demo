//
//  ViewController.swift
//  EducationDemo
//
//  Created by ALOK on 16/11/22.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        var myStringValue : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showData()
        
        // Do any additional setup after loading the view.
    }

    func showData()
        {
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Teacher")
            request.predicate = NSPredicate (format: "email == %@", myStringValue!)
            do
            {
                let result = try context.fetch(request)
                if result.count > 0
                {
                    let email = (result[0] as AnyObject).value(forKey: "email") as! String
                    let fname = (result[0] as AnyObject).value(forKey: "fname") as! String
                    let lname = (result[0] as AnyObject).value(forKey: "lname") as! String
                    let pwd = (result[0] as AnyObject).value(forKey: "password") as! String
                    
                    print(email+fname+lname+pwd);
                }
            }
            catch {
                //handle error
                print(error)
            }
        }
    

}

