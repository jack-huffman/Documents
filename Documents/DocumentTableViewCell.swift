//
//  DocumentTableViewCell.swift
//  Documents
//
//  Created by Jack Huffman on 1/31/19.
//  Copyright © 2019 Jack Huffman. All rights reserved.
//

import UIKit

class DocumentTableViewCell: UITableViewCell {

    // Cell labels
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var sizeLabel: UILabel!
    @IBOutlet weak var modifiedLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
