//
//  NoteTableViewCell.swift
//  Note
//
//  Created by Pavel N on 7/15/19.
//  Copyright © 2019 Pavel N. All rights reserved.
//

import UIKit

class NoteTableViewCell: UITableViewCell {

    @IBOutlet var colorLabel: UILabel!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var textNoteLabel: UILabel!
    var noteColor:UIColor = .white {
        didSet {
            colorLabel.backgroundColor = noteColor
            setNeedsDisplay()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        colorLabel.layer.borderWidth = 1
        colorLabel.layer.borderColor = UIColor.black.cgColor
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
