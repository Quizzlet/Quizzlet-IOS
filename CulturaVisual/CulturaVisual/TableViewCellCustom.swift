//
//  TableViewCellCustom.swift
//  CulturaVisual
//
//  Created by Maggie Jimenez Herrera on 10/13/19.
//  Copyright © 2019 Maggie Jimenez Herrera. All rights reserved.
//

import UIKit

class TableViewCellCustom: UITableViewCell {
    
    
    @IBOutlet weak var lbTema: UILabel!
    @IBOutlet weak var pvProgreso: UIProgressView!
    @IBOutlet weak var lbCont: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
