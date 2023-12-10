//
//  SpecialCell.swift
//  Marvel App
//
//  Created by Jad Ghoson on 29/11/2023.
//

import UIKit

class SpecialCell: UITableViewCell {

    
    @IBOutlet weak var boxOfCell: UIView!
    

    @IBOutlet weak var bodyLabel: UILabel!
    
    
    @IBOutlet weak var imageCharacter: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        boxOfCell.layer.cornerRadius = boxOfCell.frame.size.height/6
        boxOfCell.backgroundColor = UIColor.darkGray
        imageCharacter.layer.cornerRadius = imageCharacter.frame.size.height/6
        
        titleLabel.textColor = UIColor.white
        
    boxOfCell.layer.borderWidth = 10
    boxOfCell.layer.borderColor = CGColor(#colorLiteral(red: 0, green: 0.07058823529, blue: 0.2549019608, alpha: 1))
      
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
