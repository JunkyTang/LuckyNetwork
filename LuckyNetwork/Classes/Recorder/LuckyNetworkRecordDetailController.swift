//
//  LuckyNetworkRecordDetailController.swift
//  LuckyNetwork
//
//  Created by junky on 2024/11/4.
//

import UIKit

class LuckyNetworkRecordDetailController: UIViewController {

    
    @IBOutlet weak var contentLab: UILabel!
    
    var record: Record
    
    public init(record: Record) {
        self.record = record
        super.init(nibName: "LuckyNetworkRecordDetailController", bundle: Bundle(for: LuckyNetworkRecordDetailController.self))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        contentLab.text = record.content
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
