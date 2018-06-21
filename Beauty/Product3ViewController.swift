//
//  Product3ViewController.swift
//  Beauty
//
//  Created by Lizzy on 2018/6/21.
//  Copyright © 2018年 L&L. All rights reserved.
//

import UIKit

class Product3ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
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
    var product : Product3?
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let dateFormatter = DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        
        if product != nil {
            doneButton.isEnabled = false
            
            imageView.image = UIImage(data: product!.image3!)
            imageButton.isHidden = true
            
            nameText.text = product!.name3
            nameText.isEnabled = false
            
            brandText.text = product!.brand3
            brandText.isEnabled = false
            
            categoryText.text = product!.category3
            categoryText.isEnabled = false
            
            produceDateText.text = product!.producedate3
            produceDateText.isEnabled = false
            
            openDateText.text = product!.opendate3
            openDateText.isEnabled = false
            
            expireDateText.text = product!.expiredate3
            expireDateText.isEnabled = false
            
            effectText.text = String(product!.effectperiod3)
            effectText.isEnabled = false
            
            openSwitch.isOn = product!.open3
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
            product!.name3 = nameText.text
            product!.brand3 = brandText.text
            product!.category3 = categoryText.text
            product!.producedate3 = produceDateText.text
            product!.opendate3 = openDateText.text
            product!.expiredate3 = expireDateText.text
            product!.image3 = UIImageJPEGRepresentation(imageView.image!, 0.0)
            product!.effectperiod3 = Int16(effectText.text!)!
            product!.open3 = openSwitch.isOn
            do {
                try context.save()
            } catch { print("Save Error")}
            self.viewDidLoad()
        } else {
            let product = Product3(context: context)
            product.name3 = nameText.text
            product.brand3 = brandText.text
            product.category3 = categoryText.text
            product.producedate3 = produceDateText.text
            product.opendate3 = openDateText.text
            product.expiredate3 = expireDateText.text
            product.image3 = UIImageJPEGRepresentation(imageView.image!, 0.0)
            product.effectperiod3 = Int16(effectText.text!)!
            product.open3 = openSwitch.isOn
            do {
                try context.save()
            } catch { print("Save Error")}
            navigationController?.popViewController(animated: true)
        }
    }
}
