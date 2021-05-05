//
//  DonateTab1OverviewSupermarket.swift
//  
//
//  Created by Student on 11/1/19.
//

import UIKit

class DonateTab1OverviewSupermarket: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var deliveryLabel: UILabel!
    @IBOutlet weak var donationView: UIView!
    
    @IBOutlet weak var itemsOverviewTableView: UITableView!
    
    var nameDonateur : String = ""
    var dateDonation : String = ""
    var timeDonation : String = ""
    var deliveryDonation : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        donationView.layer.cornerRadius = 10
        itemsOverviewTableView.layer.cornerRadius = 10
        itemsOverviewTableView.separatorStyle = .singleLine
        itemsOverviewTableView.separatorColor = UIColor.gray
        itemsOverviewTableView.separatorInset = .zero
        
        // Do any additional setup after loading the view.
        nameLabel.text = nameDonateur
        dateLabel.text = dateDonation
        timeLabel.text = timeDonation
        deliveryLabel.text = deliveryDonation
        
        self.itemsOverviewTableView.delegate = self
        self.itemsOverviewTableView.dataSource = self
    }
    
    // MARK: - TableView Delegate & Data Sources
    func numberOfSections(in tableView: UITableView) -> Int{
        return 1
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let returnedView = UIView(frame: CGRect(x: 0, y: 0, width: 378, height: 465.5)) //set these values as necessary
        returnedView.backgroundColor = #colorLiteral(red: 0.9637245536, green: 0.942219913, blue: 0.8187894225, alpha: 1)

        let label = UILabel(frame: CGRect(x: 15, y: 3, width: 100, height: 30))
        
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.text = "Items:"
        returnedView.addSubview(label)

        return returnedView
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int)-> Int{
        return Items.shared.ListItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! ItemCell
        
        cell.item = Items.shared.ListItems[indexPath.row]
        return cell
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
