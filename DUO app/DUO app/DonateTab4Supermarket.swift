//
//  DonateTab4Supermarket.swift
//  DUO app
//
//  Created by Student on 24/10/2019.
//  Copyright © 2019 Angel & Esmee. All rights reserved.
//

import UIKit

class DonateTab4Supermarket: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    

    @IBOutlet weak var ItemsTableView: UITableView!
    @IBOutlet weak var AddMoreButton: UIButton!
    @IBOutlet weak var NextButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        ItemsTableView.layer.cornerRadius = 10
        ItemsTableView.separatorInset = .zero
        
        ItemsTableView.dataSource = self
        ItemsTableView.delegate = self
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Items.shared.ListItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
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
