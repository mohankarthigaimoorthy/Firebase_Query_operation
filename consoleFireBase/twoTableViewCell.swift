//
//  twoTableViewCell.swift
//  consoleFireBase
//
//  Created by Mohan K on 21/04/23.
//

import UIKit

class twoTableViewCell: UITableViewCell {

    @IBOutlet weak var text1: UILabel!
    @IBOutlet weak var text2: UILabel!
    @IBOutlet weak var text3: UILabel!
    @IBOutlet weak var text4: UILabel!
    @IBOutlet weak var text5: UILabel!
    @IBOutlet weak var text6: UILabel!
    @IBOutlet weak var textFieldone: UITextField!
    @IBOutlet weak var textFieldtwo: UITextField!
    @IBOutlet weak var textFieldthree: UITextField!
    @IBOutlet weak var textFieldfour: UITextField!
    @IBOutlet weak var textFieldfive: UITextField!
    @IBOutlet weak var textFieldsix: UITextField!
  
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
