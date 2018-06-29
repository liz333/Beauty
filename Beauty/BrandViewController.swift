//
//  BrandViewController.swift
//  Beauty
//
//  Created by Lizzy on 2018/6/29.
//  Copyright © 2018年 L&L. All rights reserved.
//

import UIKit

class BrandViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var brandTV: UITableView!
    
    let brands = ["雅诗兰黛", "兰蔻"]

    override func viewDidLoad() {
        super.viewDidLoad()
        brandTV.dataSource = self
        brandTV.delegate = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return brands.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = brands[indexPath.row]
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        navigationController?.popViewController(animated: true)
    }
}
