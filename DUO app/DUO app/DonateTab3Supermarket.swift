//
//  DonateTab3Supermarket.swift
//  DUO app
//
//  Created by Student on 10/11/19.
//  Copyright © 2019 Angel & Esmee. All rights reserved.
//

import UIKit

protocol QRVCDelegate: class{    
    func scanned(sender: QRViewController)
 }

class DonateTab3Supermarket: UIViewController, UITableViewDataSource, UITableViewDelegate, QRVCDelegate {

    @IBOutlet var StepperView: UIView!
    @IBOutlet weak var quantityStepper: UIStepper!
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var scannedItemsTableView: UITableView!
    @IBOutlet weak var FinishButton: UIButton!
    var selectedItemName: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scannedItemsTableView.layer.cornerRadius = 10
        scannedItemsTableView.separatorInset = .zero
        
        if (Items.shared.ListItems.count != 0)
        {
            // Enable Finish Scanning button.
            self.FinishButton.isEnabled = true
            self.FinishButton.setTitleColor(UIColor.white, for: .normal)
        }
        else
        {
            // Disable Finish Scanning button.
            FinishButton.isEnabled = false
            FinishButton.setTitleColor(UIColor.gray, for: .disabled)
        }
        
        

        // Do any additional setup after loading the view.
        scannedItemsTableView.dataSource = self
        scannedItemsTableView.delegate = self
                        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier != "FinishScanning")
        {
            let controller = segue.destination as! QRViewController
            controller.delegate = self
        }
    }
    
    func scanned(sender: QRViewController){
        DispatchQueue.main.async {
            self.scannedItemsTableView.reloadData()
            
            // Enable Finish Scanning button.
            self.FinishButton.isEnabled = true
            self.FinishButton.setTitleColor(UIColor.white, for: .normal)
        }
    }
    
    // MARK: - TableView Delegate & Data Sources
    func numberOfSections(in tableView: UITableView) -> Int{
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int)-> Int{
        return Items.shared.ListItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! ItemCell
        
        cell.item = Items.shared.ListItems[indexPath.row]
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        var cell: ItemCell
        cell = tableView.cellForRow(at: indexPath) as! ItemCell
        selectedItemName = cell.getName()
       
        StepperView.layer.cornerRadius = 10
        self.view.addSubview(StepperView)
        StepperView.center = self.view.center
        quantityLabel.text = String(Items.shared.GetQuantity(itemName: selectedItemName))
        quantityStepper.value = Double(Items.shared.GetQuantity(itemName: selectedItemName))
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    @IBAction func stepperValueChanged(_ sender: Any) {
        quantityLabel.text = Int(quantityStepper.value).description
       }
    
    @IBAction func UpdateButton(_ sender: Any) {
        Items.shared.ChangeQuantity(name: selectedItemName, quantity: Int(quantityStepper.value))
        self.scannedItemsTableView.reloadData()
        self.StepperView.removeFromSuperview()
    }
    
    @IBAction func CancelButton(_ sender: Any) {
        self.StepperView.removeFromSuperview()
        self.scannedItemsTableView.reloadData()

       }

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
