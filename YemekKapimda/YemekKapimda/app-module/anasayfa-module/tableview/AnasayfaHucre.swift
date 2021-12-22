//
//  AnasayfaHucre.swift
//  YemekKapimda
//
//  Created by Asit Aslan on 8.12.2021.
//  Copyright © 2021 Asit Aslan. All rights reserved.
//

import UIKit

class AnasayfaHucre: UITableViewCell {
    
    
    @IBOutlet weak var anasayfaImage: UIImageView!
    @IBOutlet weak var yemekAdLabel: UILabel!
    @IBOutlet weak var yemekFiyatLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
