//
//  HomeTableViewCell.swift
//  EpitechEisenhower
//
//  Created by Kevin Djedje on 31/03/2018.
//

import UIKit

class HomeTableViewCell: UITableViewCell {

    @IBOutlet weak var firstTaskView: TaskView!
    @IBOutlet weak var secondTaskView: Task2View!
    @IBOutlet weak var addButton: UIButton!
    
    var leftView: TaskView = TaskView(frame: CGRect(x: 8, y: 16, width: 158, height: 81))
    var rightView: TaskView = TaskView(frame: CGRect(x: 177, y: 16, width: 158, height: 81))
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.isUserInteractionEnabled = false
        self.selectionStyle = .none
        firstTaskView.isHidden = false
        secondTaskView.isHidden = false
        addButton.isHidden = true
        
        firstTaskView.style = .regular
        print("Premiere Tache modifié")
        secondTaskView.style = .importanteAndUrgente
        
    
    }

    @objc private func touchTaskView(viewTouched: UIView) {
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func addButtonDidPressed() {
        print("Add Button worked")
    }
}
