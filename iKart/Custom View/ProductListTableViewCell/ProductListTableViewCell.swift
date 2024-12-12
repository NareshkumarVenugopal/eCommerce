//
//  ProductListTableViewCell.swift
//  iKart
//
//  Created by Jasmin Infotech Private Limited on 27/11/24.
//

import UIKit

class ProductListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productIdLabel: UILabel!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var viewDetailsBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    
    
}
