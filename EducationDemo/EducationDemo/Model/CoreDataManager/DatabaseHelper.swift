//
//  DatabaseHelper.swift
//  EducationDemo
//
//  Created by ALOK on 17/11/22.
//

import UIKit
import CoreData

class DatabaseHelper: NSObject {
    
    static let shareInstance = DatabaseHelper()
    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
     

    func saveStudentData(studentDict: [String:String]){
        let student = NSEntityDescription.insertNewObject(forEntityName:
        "Student", into: context) as! Student
        student.rollno = studentDict["rollno"]
        student.name = studentDict["name"]
        student.hindi = studentDict["hindi"]
        student.english = studentDict["english"]
        student.math = studentDict["math"]
        
            do {
        try context.save()
        }catch let err{
        print ("college save error :- \(err.localizedDescription)")
        }
    }
    
    func getStudentData() -> [Student] {
        
        var arrStudent = [Student]()
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Student")
        do{
            arrStudent = try context.fetch(fetchRequest) as! [Student];
            print("data saved");
        }catch let err {
            print("Error in student fetch \(err)")
        }
        return arrStudent
        
    }

}
