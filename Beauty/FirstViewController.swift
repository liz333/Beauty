//
//  FirstViewController.swift
//  Beauty
//
//  Created by Lizzy on 2018/5/24.
//  Copyright © 2018年 L&L. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    

    @IBOutlet var firstTV: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        firstTV.delegate = self
        firstTV.dataSource = self
        
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        return cell
    }

}
