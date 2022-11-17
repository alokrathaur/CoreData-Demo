//
//  StudentTableViewCell.swift
//  EducationDemo
//
//  Created by ALOK on 17/11/22.
//

import UIKit

class StudentTableViewCell: UITableViewCell {

    @IBOutlet weak var lbl_name: UILabel!
    @IBOutlet weak var lbl_hindi: UILabel!
    @IBOutlet weak var lbl_eng: UILabel!
    @IBOutlet weak var lbl_math: UILabel!
    @IBOutlet weak var lbl_roll: UILabel!
    
    var student : Student? {
        didSet {
            lbl_roll.text = "Roll No: \(student?.rollno ?? "")";
            lbl_name.text = "Name: \(student?.name ?? "")";
            lbl_hindi.text = "Hindi Marks: \(student?.hindi ?? "")";
            lbl_eng.text = "English Marks: \(student?.english ?? "")";
            lbl_math.text = "Math Marks: \(student?.math ?? "")";
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
