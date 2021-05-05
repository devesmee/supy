//
//  DonateTab5Supermarket.swift
//  DUO app
//
//  Created by Student on 24/10/2019.
//  Copyright © 2019 Angel & Esmee. All rights reserved.
//

import UIKit


class DonateTab5Supermarket: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
        
    
    @IBOutlet weak var selectDateTextField: UITextField!
    @IBOutlet weak var deliveryTableView: UITableView!
    @IBOutlet weak var confirmButton: UIButton!
    
    private var datePicker: UIDatePicker?
    var deliveryOptions = [String]()
    var deliverySelected: Bool = false
    var dateTimeSelected: Bool = false
    
    var deliveryMethodString: String = ""
    var deliveryDateString: String = ""
    var deliveryTimeString: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        deliveryTableView.layer.cornerRadius = 10
        deliveryTableView.separatorInset = .zero
        
        datePicker = UIDatePicker();
        datePicker?.datePickerMode = .dateAndTime
        self.datePicker?.minimumDate = Date()
        datePicker?.addTarget(self, action: #selector(DonateTab5Supermarket.dateChanged(datePicker:)), for: .valueChanged)
        
        selectDateTextField.inputView = datePicker
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(DonateTab5Supermarket.viewTapped(gestureRecognizer:)    ))
        view.addGestureRecognizer(tapGesture)
        
       //to make sure the cell selection happens
        tapGesture.cancelsTouchesInView = false;
        self.deliveryTableView.delegate = self
        self.deliveryTableView.dataSource = self
        
        // Do any additional setup after loading the view.
        deliveryOptions.append("Bring to Voedselbank Eindhoven")
        deliveryOptions.append("Pick up by Voedselbank Eindhoven")
        
        confirmButton.isEnabled = false;
        confirmButton.setTitleColor(UIColor.gray, for: .disabled)
        
    }
    
    @objc func viewTapped(gestureRecognizer: UITapGestureRecognizer){
        view.endEditing(true)
    }
    
    @objc func dateChanged(datePicker: UIDatePicker){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMMM yyyy HH:mm"
        
        let dateConverterDate = DateFormatter()
        dateConverterDate.dateFormat = "dd/MM/yyyy"
        
        let dateConverterTime = DateFormatter()
        dateConverterTime.dateFormat = "HH:mm"
        
        selectDateTextField.text = dateFormatter.string(from: datePicker.date)
        deliveryDateString = dateConverterDate.string(from: datePicker.date)
        deliveryTimeString = dateConverterTime.string(from: datePicker.date)
        
        dateTimeSelected = true
        enableConfirmButton()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return deliveryOptions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DeliveryCell", for: indexPath)
//        cell.accessoryType = .checkmark
        cell.textLabel?.text = deliveryOptions[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        tableView.deselectRow(at: indexPath, animated: true)
       
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark

        for cellPath in tableView.indexPathsForVisibleRows!{
            if cellPath == indexPath{
                deliveryMethodString = (tableView.cellForRow(at: indexPath)?.textLabel!.text)!
                if deliveryMethodString == "Bring to Voedselbank Eindhoven"
                {
                    deliveryMethodString = "Delivery"
                }
                else
                {
                    deliveryMethodString = "Pick up"
                }
                deliverySelected = true
                enableConfirmButton()
                continue
            }
            tableView.cellForRow(at: cellPath)?.accessoryType = .none
         }
    }
    
    func enableConfirmButton(){
        if deliverySelected == true && dateTimeSelected == true
        {
            confirmButton.isEnabled = true
            confirmButton.setTitleColor(UIColor.white, for: .disabled)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "BackToUpcoming"{
            let vc = segue.destination as? DonateTab1Supermarket
            vc?.deliveryString = deliveryMethodString
            vc?.dateString = deliveryDateString
            vc?.timeString = deliveryTimeString
            vc?.boolString = false
        }
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
