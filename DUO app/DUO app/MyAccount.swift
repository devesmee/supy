//
//  MyAccount.swift
//  DUO app
//
//  Created by Student on 11/6/19.
//  Copyright © 2019 Angel & Esmee. All rights reserved.
//

import UIKit

class MyAccount: UIViewController {

    @IBOutlet weak var Logo: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        Logo.layer.masksToBounds = true
        Logo.layer.cornerRadius = 10
        Logo.layer.borderWidth = 1
        Logo.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
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
