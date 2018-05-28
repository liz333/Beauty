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
    
    var products : [Product] = []
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        firstTV.delegate = self
        firstTV.dataSource = self
       
        print(products)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        do {
            products = try context.fetch(Product.fetchRequest())
            firstTV.reloadData()
        } catch {
            print("Cannot fetch data!")
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : CustomCell = tableView.dequeueReusableCell(withIdentifier: "customCell") as! CustomCell
        let product = products[indexPath.row]
        
        cell.nameLabel!.text = product.name
        cell.cellImage!.image = UIImage(data: product.image!)
        cell.expireDateLabel!.text = product.expiredate
        if product.open == true {
            cell.openLabel!.text = "已开封"
        } else {
            cell.openLabel!.text = "未开封"
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let product = products[indexPath.row]
            context.delete(product)
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            
            do {
                products = try context.fetch(Product.fetchRequest())
                firstTV.reloadData()
            } catch {
                print("Cannot fetch data!")
            }
        }
    }
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "删除"
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nextVC = segue.destination as! ProductViewController
        nextVC.product = sender as? Product
    }
    
}
