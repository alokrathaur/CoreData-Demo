//
//  CoreDataManager.swift
//  EducationDemo
//
//  Created by ALOK on 17/11/22.
//

import Foundation
import CoreData

internal struct CoreDataManager{
    
    static let shared = CoreDataManager()
    
    let persistentContainer:NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "Teacher")
        container.loadPersistentStores {(storeDescription, error) in
            if let error = error {
                fatalError("Loading of store failed \(error)")
            }
            
        }
        return container
    }()
    
}
