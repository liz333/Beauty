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
    
    @IBAction func produceDateEdit(_ sender: UITextField) {
        let produceDatePickerView = UIDatePicker()
        produceDatePickerView.datePickerMode = UIDatePickerMode.date
        produceDatePickerView.locale = Locale(identifier: "zh_CN")
        sender.inputView = produceDatePickerView
        produceDatePickerView.addTarget(self, action: #selector(produceDateChanged), for: UIControlEvents.valueChanged)
    }
    
   @objc func produceDateChanged (sender: UIDatePicker){
        let produceDateFormatter = DateFormatter()
        produceDateFormatter.dateFormat = "yyyy年MM月dd日"
        produceDateText.text = produceDateFormatter.string(from: sender.date)
    }
    
    @objc func dismissPicker() {
        produceDateText.endEditing(true)
    }
    
    @IBAction func openDateEdit(_ sender: UITextField) {
    }
    
    
    @IBAction func expireDateEdit(_ sender: UITextField) {
    }
    
    
}
