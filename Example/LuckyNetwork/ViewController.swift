//
//  ViewController.swift
//  LuckyNetWork
//
//  Created by 汤俊杰 on 02/23/2024.
//  Copyright (c) 2024 汤俊杰. All rights reserved.
//

import UIKit
import LuckyNetwork
import Alamofire

class ViewController: UIViewController {

    
    var session: Alamofire.Session?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "record", style: .done, target: self, action: #selector(goRecorder))
        
    }
    
    @objc func goRecorder() {
        navigationController?.pushViewController(LuckyNetworkRecordController(), animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func actionDataReq(_ sender: Any) {
        
        Task.detached {
            do {
                let res = try await DataTask(parameters: .init(lang: "en")).request()
                print(res)
            } catch {
                print(error)
            }
        }
    }
    
    @IBAction func actionUploadReq(_ sender: Any) {
        
        guard let image = UIImage(named: "test"),
              let data = image.pngData()
        else {
            print("[ERROR]: 图片加载错误")
            return
        }
        
        UploadTask().upload(datas: [data], name: "file") { print($0) } compelete: { _ in }
    }
    
    @IBAction func actionDownloadReq(_ sender: Any) {
        
        DownloadTask().download { progress in
            print(progress)
        } compelete: { resp in
            print(resp.debugDescription)
        }

        
    }
    
    
}

