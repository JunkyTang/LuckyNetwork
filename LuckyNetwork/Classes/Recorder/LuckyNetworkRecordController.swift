//
//  LuckyNetworkRecordController.swift
//  LuckyNetwork
//
//  Created by junky on 2024/11/4.
//

import UIKit
@preconcurrency import Combine

public class LuckyNetworkRecordController: UIViewController {

    
    
    @IBOutlet weak var tableView: UITableView!
    
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: "LuckyNetworkRecordController", bundle: Bundle(for: LuckyNetworkRecordController.self))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var cancellables: Set<AnyCancellable> = []
    deinit {
        cancellables.forEach{ $0.cancel() }
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        bindVM()
    }

    
    var list: [Record] = []
    
    

}


extension LuckyNetworkRecordController {
    
    func setupUI() {
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "clear", style: .done, target: self, action: #selector(clear))
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "LuckyNetworkRecordCell", bundle: Bundle(for: LuckyNetworkRecordCell.self)), forCellReuseIdentifier: "LuckyNetworkRecordCell")
    }
    
    @objc func clear() {
        RecordStorage.clean()
    }
    
    
    func bindVM() {
        
        RecordStorage.$needRefresh.receive(on: DispatchQueue.main).sink { [weak self] _ in
            guard let weakself = self else { return }
            weakself.list = RecordStorage.recordList
            weakself.tableView.reloadData()
        }.store(in: &cancellables)
        
    }
    
}


extension LuckyNetworkRecordController: UITableViewDelegate, UITableViewDataSource {
    
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "LuckyNetworkRecordCell") as? LuckyNetworkRecordCell
        else { fatalError() }
        cell.model = list[indexPath.row]
        return cell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let vc = LuckyNetworkRecordDetailController(record: list[indexPath.row])
        if let navi = navigationController {
            navi.pushViewController(vc, animated: true)
        }else{
            present(vc, animated: true)
        }
        
    }
}
