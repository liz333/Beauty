//
//  ProductViewController.swift
//  Beauty
//
//  Created by Lizzy on 2018/5/25.
//  Copyright © 2018年 L&L. All rights reserved.
//

import UIKit

class ProductViewController: UIViewController {
    
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var nameText: UITextField!
    @IBOutlet var brandText: UITextField!
    @IBOutlet var categoryText: UITextField!
    @IBOutlet var produceDateText: UITextField!
    @IBOutlet var openSwitch: UISwitch!
    @IBOutlet var effectText: UITextField!
    @IBOutlet var openDateText: UITextField!
    @IBOutlet var expireDateText: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    
    @IBAction func cameraTapped(_ sender: Any) {
    }
    
    
    @IBAction func doneTapped(_ sender: Any) {
    }
    
    
    @IBAction func textBeginEdit(_ sender: UITextField) {
        //Pop-up date picker window
        let datePickerView = UIDatePicker()
        sender.inputView = datePickerView
        datePickerView.datePickerMode = UIDatePickerMode.date
        datePickerView.locale = Locale(identifier: "zh_CN")
        datePickerView.addTarget(self, action: #selector(dateChanged), for: UIControlEvents.valueChanged)
        
        //Add a button to date picker view
        let navigationBar = UINavigationBar()
        sender.inputAccessoryView = navigationBar
        navigationBar.barStyle = UIBarStyle.default
        navigationBar.sizeToFit()
        let navigationItem = UINavigationItem()
        navigationBar.setItems([navigationItem], animated: false)
        let doneButton = UIBarButtonItem(title: "完成", style: UIBarButtonItemStyle.plain, target: self, action: #selector(dismissPicker))
        navigationItem.setRightBarButtonItems([doneButton], animated: false)
    }
    
    
    @objc func dateChanged (sender: UIDatePicker){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy年MM月dd日"
        produceDateText.text = dateFormatter.string(from: sender.date)
    }
    
    @objc func dismissPicker() {
        produceDateText.endEditing(true)
    }
    
    
    
}
