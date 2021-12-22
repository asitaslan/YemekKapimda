//
//  SepetHucre.swift
//  YemekKapimda
//
//  Created by Asit Aslan on 8.12.2021.
//  Copyright © 2021 Asit Aslan. All rights reserved.
//

import UIKit

class SepetHucre: UITableViewCell {

    @IBOutlet weak var sepetImage: UIImageView!
    @IBOutlet weak var yemekAdLabel: UILabel!
    @IBOutlet weak var fiyatLabel: UILabel!
    @IBOutlet weak var adetLabel: UILabel!
    @IBOutlet weak var totalFiyatLabel: UILabel!
    @IBOutlet weak var stepper: UIStepper!
    var total = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func sepetStapper(_ sender: UIStepper) {
        adetLabel.text = String(Int(sender.value))
        total = Int(fiyatLabel.text!)! * Int(adetLabel.text!)!
        totalFiyatLabel.text = "Tutar:\(total)₺"
    }
}
