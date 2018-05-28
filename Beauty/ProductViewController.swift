//
//  ProductViewController.swift
//  Beauty
//
//  Created by Lizzy on 2018/5/25.
//  Copyright © 2018年 L&L. All rights reserved.
//

import UIKit

class ProductViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet var imageButton: UIButton!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var nameText: UITextField!
    @IBOutlet var brandText: UITextField!
    @IBOutlet var categoryText: UITextField!
    @IBOutlet var produceDateText: UITextField!
    @IBOutlet var openSwitch: UISwitch!
    @IBOutlet var effectText: UITextField!
    @IBOutlet var openDateText: UITextField!
    @IBOutlet var expireDateText: UITextField!
    
    
    var imagePicker = UIImagePickerController()
    var product : Product?
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let dateFormatter = DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        
        dateFormatter.dateFormat = "yyyy年MM月dd日"
        produceDateText.text = dateFormatter.string(from: Date())
        openDateText.text = dateFormatter.string(from: Date())
        expireDateText.text = dateFormatter.string(from: Date())
    }
    
    @IBAction func imageButtonTapped(_ sender: Any) {
        imagePicker.sourceType = .camera
        present(imagePicker, animated: true, completion: nil)
        imageButton.isHidden = true
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let productImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        imageView.image = productImage
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        imagePicker.dismiss(animated: true, completion: nil)
        imageButton.isHidden = false
    }
    
    @IBAction func textBeginEdit(_ sender: UITextField) {
        //Pop-up date picker window
        let datePickerView = UIDatePicker()
        sender.inputView = datePickerView
        datePickerView.datePickerMode = UIDatePickerMode.date
        datePickerView.locale = Locale(identifier: "zh_CN")
        datePickerView.date = Date()
        datePickerView.addTarget(self, action: #selector(textFinishEdit(_:)), for: UIControlEvents.valueChanged)
        
        //Add a button to date picker view
        let navigationBar = UINavigationBar()
        sender.inputAccessoryView = navigationBar
        navigationBar.barStyle = UIBarStyle.default
        navigationBar.sizeToFit()
        let navigationItem = UINavigationItem()
        navigationBar.setItems([navigationItem], animated: false)
        let doneButton = UIBarButtonItem(title: "完成", style: UIBarButtonItemStyle.plain, target: self, action:#selector(dismissDatePicker))
        navigationItem.setRightBarButtonItems([doneButton], animated: false)
    }
    
    
    @objc func dismissDatePicker() {
        produceDateText.endEditing(true)
        openDateText.endEditing(true)
        expireDateText.endEditing(true)
    }
    
    
    @IBAction func textFinishEdit(_ sender: UIDatePicker) {
        dateFormatter.dateFormat = "yyyy年MM月dd日"
        if sender == produceDateText.inputView {
            produceDateText.text = dateFormatter.string(from: sender.date)
        }
        if sender == openDateText.inputView {
            openDateText.text = dateFormatter.string(from: sender.date)
        }
        if sender == expireDateText.inputView {
            expireDateText.text = dateFormatter.string(from: sender.date)
        }
    }
    
    
    @IBAction func brandTextEdit(_ sender: UITextField) {
        performSegue(withIdentifier: "brandSegue", sender: brandText)
    }
    
    
    @IBAction func categoryTextEdit(_ sender: UITextField) {
        performSegue(withIdentifier: "categorySegue", sender: categoryText)
    }
    
    
    @IBAction func openSwitchChanged(_ sender: UISwitch) {
        if openSwitch.isOn != true {
            openDateText.text = " "
            openDateText.isEnabled = false
        } else {
            openDateText.isEnabled = true
            dateFormatter.dateFormat = "yyyy年MM月dd日"
            openDateText.text = dateFormatter.string(from: Date())
        }
    }
    
    @IBAction func doneTapped(_ sender: Any) {
        product?.image = UIImagePNGRepresentation(imageView.image!)
        product?.name = nameText.text
        product?.brand = brandText.text
        product?.category = categoryText.text
        product?.producedate = produceDateText.text
        product?.opendate = openDateText.text
        product?.expiredate = expireDateText.text
        //need test:
        product?.effectperiod = Int16(effectText.text!)!
        product?.open = openSwitch.isOn
        do {
            try context.save()
        } catch { print("Save Error")}
        navigationController?.popViewController(animated: true)
    }
}
