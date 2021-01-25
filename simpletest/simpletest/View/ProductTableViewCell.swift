//
//  ProductTableViewCell.swift
//  simpletest
//
//  Created by 唐紹桓 on 2021/1/21.
//

import UIKit

class ProductTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var suggestPriceLabel: UILabel!
    
    @IBOutlet weak var sellingQtyLabel: UILabel!
    
    @IBOutlet weak var sellingStartDateTime: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupData(data: SalePageList) {
        
        titleLabel.text = data.title
        
        priceLabel.text = String(data.price ?? 0)
        
        suggestPriceLabel.text = String(data.suggestPrice ?? 0)
        
        sellingQtyLabel.text = String(data.sellingQty ?? 0)
    
        // 時間轉換
        
        sellingStartDateTime.text = data.sellingStartDateTime?.transformDataString()
     }
}
