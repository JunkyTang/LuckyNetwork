//
//  LuckyNetworkRecordCell.swift
//  LuckyNetwork
//
//  Created by junky on 2024/11/4.
//

import UIKit

class LuckyNetworkRecordCell: UITableViewCell {

    
    @IBOutlet weak var codeLab: UILabel!
    
    @IBOutlet weak var methodLab: UILabel!
    
    @IBOutlet weak var urlLab: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var model: Record = Record(content: "") {
        didSet {
            reload()
        }
    }
    
    
    func reload() {
        
        codeLab.text = "\(model.code ?? -1)"
        methodLab.text = model.method ?? "None"
        urlLab.text = model.url?.absoluteString ?? "None"
    }
    
}
