//
//  StudentListViewController.swift
//  EducationDemo
//
//  Created by ALOK on 17/11/22.
//

import UIKit
import CoreData

class StudentListViewController: UIViewController {

    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        var myStringValue : String?
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var btn_addStudent: UIButton!
    
    @IBOutlet weak var view_popUp: UIView!
    
    @IBOutlet weak var txf_rollNo: UITextField!
    @IBOutlet weak var txf_name: UITextField!
    @IBOutlet weak var txf_hindi: UITextField!
    @IBOutlet weak var txf_english: UITextField!
    @IBOutlet weak var txf_math: UITextField!
    
    var studentData = [Student]()
    
    var updateDataBool = false;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self;
        tableView.dataSource = self;
        
        view_popUp.isHidden = true;
        studentData = getAllStudentData();
        self.tableView.reloadData();
        // Do any additional setup after loading the view.
    }
    
    @IBAction func openPopUpAction(_ sender: Any) {
        
        txf_rollNo.text = ""
        txf_name.text = ""
        txf_hindi.text = ""
        txf_english.text = ""
        txf_math.text = ""
        
        view_popUp.isHidden = false;
        
    }
    
    
    @IBAction func saveStudentDataAction(_ sender: Any) {
        if(validationCheck()){
            if(updateDataBool){
                updateStudentData(rollNo: txf_rollNo.text ?? "");
            }else{
                collegeSaveData();
            }
        }
        
    }
    
    func validationCheck() -> Bool {
        
        if txf_rollNo.text?.count == 0{
            Util().showPopUpToast(message: "Enter Student Roll No.", vc: self)
            
            return false
        }else if txf_name.text?.count == 0{
            Util().showPopUpToast(message: "Enter Student name.", vc: self)
            
            return false
        }else if txf_hindi.text?.count == 0 {
            Util().showPopUpToast(message: "Enter Hindi marks", vc: self)
            
            return false
        }else if txf_english.text?.count == 0 {
            Util().showPopUpToast(message: "Enter English marks", vc: self)
            
            return false
        }else if txf_math.text?.count == 0 {
            Util().showPopUpToast(message: "Enter Math marks", vc: self)
            
            return false
        }
        return true
    }
    
    
    
    @IBAction func closePopUpAction(_ sender: Any) {
        view_popUp.isHidden = true;
    }
    
    @IBAction func backAction(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
        
    }
    

}

extension StudentListViewController {
    
    func updateStudentData(rollNo: String){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
            let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest:NSFetchRequest = NSFetchRequest<NSFetchRequestResult>.init(entityName: "Student")
            fetchRequest.predicate = NSPredicate(format: "rollno = %@", rollNo)
        let fetchRequestName:NSFetchRequest = NSFetchRequest<NSFetchRequestResult>.init(entityName: "Student")
        fetchRequestName.predicate = NSPredicate(format: "name = %@", txf_name.text ?? "")
           
        do {
            
               let rollNoFound = try managedContext.fetch(fetchRequest)
               let nameFound = try managedContext.fetch(fetchRequestName)
//               if (nameFound.count > 0) {
//                   Util().showPopUpToast(message: "Student already have with same name.", vc: self)
//               }else{
//
//               }
             let test = try managedContext.fetch(fetchRequest)
            let objectUpdate = test[0] as! NSManagedObject
         
         print(test);
         
         objectUpdate.setValue(txf_rollNo.text, forKey: "rollno")
         objectUpdate.setValue(txf_name.text, forKey: "name")
         objectUpdate.setValue(txf_hindi.text, forKey: "hindi")
         objectUpdate.setValue(txf_english.text, forKey: "english")
         objectUpdate.setValue(txf_math.text, forKey: "math")
            do {
                try managedContext.save()
                studentData = getAllStudentData();
                self.view_popUp.isHidden = true;
                self.tableView.reloadData();
                
            }
            catch {
                print(error)
            }
            
        } catch {
            print(error)
        }
        
    }
    
   


    func save() {
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
    }
    
    func collegeSaveData(){
        guard let rollno = txf_rollNo.text else { return }
        guard let name = txf_name.text else { return }
        guard let hindi = txf_hindi.text else { return }
        guard let english = txf_english.text else { return }
        guard let math = txf_math.text else { return }
                
        let studentDict = [
            "rollno": rollno,
            "name": name,
            "hindi": hindi,
            "english": english,
            "math": math
            ]
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
            let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest:NSFetchRequest = NSFetchRequest<NSFetchRequestResult>.init(entityName: "Student")
            fetchRequest.predicate = NSPredicate(format: "rollno = %@", rollno)
            
        let fetchRequestName:NSFetchRequest = NSFetchRequest<NSFetchRequestResult>.init(entityName: "Student")
        fetchRequestName.predicate = NSPredicate(format: "name = %@", name)
              
        
        do {
            let rollNoFound = try managedContext.fetch(fetchRequest)
            let nameFound = try managedContext.fetch(fetchRequestName)
            if(rollNoFound.count > 0){
                Util().showPopUpToast(message: "Student already have with same roll no.", vc: self)
                
            }else if (nameFound.count > 0) {
                Util().showPopUpToast(message: "Student already have with same name.", vc: self)
            }else{
                DatabaseHelper.shareInstance.saveStudentData(studentDict: studentDict)
                studentData = getAllStudentData();
                self.view_popUp.isHidden = true;
                self.tableView.reloadData();
            }
            
        }catch {}
        
        
     
    }
    
    func getAllStudentData() -> [Student]{
        var arrStudent = [Student]()
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Student")
        do{
            arrStudent = try context.fetch(fetchRequest) as! [Student]
        }catch let err{
        print( "Error in college fetch \(err.localizedDescription)")
        }
        return arrStudent
    }
    
}

extension StudentListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        studentData.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StudentTableViewCell", for: indexPath) as! StudentTableViewCell
        cell.student = studentData[indexPath.row]
        cell.selectionStyle = .none;
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //
        self.updateDataBool = true;
        let studData = studentData[indexPath.row]
        self.txf_rollNo.text = studData.rollno;
        self.txf_name.text = studData.name;
        self.txf_hindi.text = studData.hindi;
        self.txf_english.text = studData.english;
        self.txf_math.text = studData.math;
        
        self.view_popUp.isHidden = false;
    }
    
    
    
}
