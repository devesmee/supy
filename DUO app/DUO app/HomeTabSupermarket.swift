//
//  HomeTabSupermarket.swift
//  DUO app
//
//  Created by Student on 07/10/2019.
//  Copyright © 2019 Angel & Esmee. All rights reserved.
//

import UIKit

class HomeTabSupermarket: UIViewController {

    @IBOutlet weak var totalDonationsView: UIView!
    @IBOutlet weak var sheltersHelpedView: UIView!
    @IBOutlet weak var moneySavedView: UIView!
    @IBOutlet weak var averageRatingView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        totalDonationsView.layer.cornerRadius = 10
        sheltersHelpedView.layer.cornerRadius = 10
        moneySavedView.layer.cornerRadius = 10
        averageRatingView.layer.cornerRadius = 10
        // Do any additional setup after loading the view.
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
