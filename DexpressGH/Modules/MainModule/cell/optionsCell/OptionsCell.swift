//
//  OptionsCell.swift
//  DexpressGH
//
//  Created by Tracer on 01/12/20.
//  Copyright © 2020 Tracer. All rights reserved.
//

import UIKit

class OptionsCell: UITableViewCell {

    @IBOutlet weak var optionImage: UIImageView!
    @IBOutlet weak var optionTextLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configure(withOptions option: String) {
        self.optionTextLbl.text = option
        self.backgroundColor = UIColor.tracerGray
        self.optionTextLbl.textColor = UIColor.tracerGreen
        //TODO: add image according to option
    }
}
