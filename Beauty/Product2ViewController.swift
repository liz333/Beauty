//
//  Product2ViewController.swift
//  Beauty
//
//  Created by Lizzy on 2018/6/21.
//  Copyright © 2018年 L&L. All rights reserved.
//

import UIKit

class Product2ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIPickerViewDataSource, UIPickerViewDelegate {
    
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
    @IBOutlet var changeButton: UIButton!
    @IBOutlet var doneButton: UIBarButtonItem!
    
    var imagePicker = UIImagePickerController()
    var product : Product2?
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let dateFormatter = DateFormatter()
    let categoryPicker = UIPickerView()
    let categoryList = [" ", "化妆品"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        categoryPicker.dataSource = self
        categoryPicker.delegate = self
        
        if product != nil {
            doneButton.isEnabled = false
            
            imageView.image = UIImage(data: product!.image2!)
            imageButton.isHidden = true
            
            nameText.text = product!.name2
            nameText.isEnabled = false
            
            brandText.text = product!.brand2
            brandText.isEnabled = false
            
            categoryText.text = product!.category2
            categoryText.isEnabled = false
            
            produceDateText.text = product!.producedate2
            produceDateText.isEnabled = false
            
            openDateText.text = product!.opendate2
            openDateText.isEnabled = false
            
            expireDateText.text = product!.expiredate2
            expireDateText.isEnabled = false
            
            effectText.text = String(product!.effectperiod2)
            effectText.isEnabled = false
            
            openSwitch.isOn = product!.open2
            openSwitch.isEnabled = false
        } else {
            changeButton.isHidden = true
            dateFormatter.dateFormat = "yyyy年MM月dd日"
            produceDateText.text = dateFormatter.string(from: Date())
            openDateText.text = dateFormatter.string(from: Date())
            expireDateText.text = dateFormatter.string(from: Date())
        }
    }
    
    @IBAction func imageButtonTapped(_ sender: Any) {
        imagePicker.sourceType = .camera
        imagePicker.cameraFlashMode = .auto
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
    
    
    @IBAction func dismissKeyboard(_ sender: UITextField) {
        self.nameText.endEditing(true)
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
    
    @IBAction func categoryBeginEdit(_ sender: UITextField) {
        categoryText.inputView = categoryPicker
        
        let navigationBar = UINavigationBar()
        sender.inputAccessoryView = navigationBar
        navigationBar.barStyle = UIBarStyle.default
        navigationBar.sizeToFit()
        let navigationItem = UINavigationItem()
        navigationBar.setItems([navigationItem], animated: false)
        let doneButton = UIBarButtonItem(title: "完成", style: UIBarButtonItemStyle.plain, target: self, action:#selector(dismissCategoryPicker))
        navigationItem.setRightBarButtonItems([doneButton], animated: false)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView( _ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categoryList.count
    }
    
    func pickerView( _ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return categoryList[row]
    }
    
    func pickerView( _ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        categoryText.text = categoryList[row]
    }
    
    
    @objc func dismissCategoryPicker() {
        categoryText.endEditing(true)
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
    
    
    @IBAction func changeTapped(_ sender: Any) {
        imageButton.isHidden = true
        nameText.isEnabled = true
        brandText.isEnabled = true
        categoryText.isEnabled = true
        produceDateText.isEnabled = true
        openDateText.isEnabled = true
        expireDateText.isEnabled = true
        effectText.isEnabled = true
        openSwitch.isEnabled = true
        doneButton.isEnabled = true
    }
    
    
    
    @IBAction func doneTapped(_ sender: Any) {
        
        if product != nil {
            product!.name2 = nameText.text
            product!.brand2 = brandText.text
            product!.category2 = categoryText.text
            product!.producedate2 = produceDateText.text
            product!.opendate2 = openDateText.text
            product!.expiredate2 = expireDateText.text
            product!.image2 = UIImageJPEGRepresentation(imageView.image!, 0.0)
            product!.effectperiod2 = Int16(effectText.text!)!
            product!.open2 = openSwitch.isOn
            do {
                try context.save()
            } catch { print("Save Error")}
            self.viewDidLoad()
        } else {
            let product = Product2(context: context)
            product.name2 = nameText.text
            product.brand2 = brandText.text
            product.category2 = categoryText.text
            product.producedate2 = produceDateText.text
            product.opendate2 = openDateText.text
            product.expiredate2 = expireDateText.text
            product.image2 = UIImageJPEGRepresentation(imageView.image!, 0.0)
            product.effectperiod2 = Int16(effectText.text!)!
            product.open2 = openSwitch.isOn
            do {
                try context.save()
            } catch { print("Save Error")}
            navigationController?.popViewController(animated: true)
        }
    }
}
