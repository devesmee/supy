//
//  CharityInfo.swift
//  DUO app
//
//  Created by Student on 11/10/2019.
//  Copyright © 2019 Angel & Esmee. All rights reserved.
//

import UIKit

class CharityInfo: UIViewController, SendSelectedCharity {
    func sendSelectedCharityForward(selectedCharity: String) {
        self.nameCharity.text = selectedCharity2
    }
    

    @IBOutlet weak var nameCharity: UILabel!
    @IBOutlet weak var addressCharity: UILabel!
    @IBOutlet weak var phoneCharity: UILabel!
    @IBOutlet weak var deliveryCharity: UILabel!
    
    var charities = [Charity]()
    var selectedCharity2 : String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(selectedCharity2)
//        self.nameCharity.text = selectedCharity2
        // fetch data
        let url = URL(string: "https://api.npoint.io/2f37a723e964986401a2")
        // http request
        URLSession.shared.dataTask(with: url!) { (data, response, error)
            in
            
            if error != nil {
                print("\(error?.localizedDescription)")
                return
            }
            do {
                let charityData = try JSONDecoder().decode([Charity].self, from: data!)
                
                self.charities = charityData
                self.viewWillAppear(true)
                
            }catch let err{
                print("\(err)")
            }
            
            DispatchQueue.main.async {
                self.nameCharity.text = self.charities[0].name
                self.addressCharity.text = self.charities[0].address
                self.phoneCharity.text = self.charities[0].phonenr
                self.deliveryCharity.text = self.charities[0].deliverymethod
            }
            
        }.resume()
        
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
