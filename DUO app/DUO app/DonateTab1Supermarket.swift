//
//  DonateTab1Supermarket.swift
//  DUO app
//
//  Created by Student on 10/10/2019.
//  Copyright © 2019 Angel & Esmee. All rights reserved.
//

import UIKit
import SAConfettiView

class DonateTab1Supermarket: UIViewController {

    @IBOutlet weak var donation1View: UIView!
    @IBOutlet weak var donation2View: UIView!
    @IBOutlet weak var donation3View: UIView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var deliveryMethodLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    var deliveryString: String = ""
    var timeString: String = ""
    var dateString: String = ""
    var boolString: Bool = true
    var timer: Timer?
    var timeLeft = 2
    var confettiView = SAConfettiView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        donation1View.layer.cornerRadius = 10
        donation2View.layer.cornerRadius = 10
        donation3View.layer.cornerRadius = 10
        // Set Navigation bar to translucent.
       self.navigationController!.navigationBar.setBackgroundImage(UIImage(), for: .default)
       self.navigationController!.navigationBar.shadowImage = UIImage()
       self.navigationController!.navigationBar.isTranslucent = true
        // Do any additional setup after loading the view.
        deliveryMethodLabel.text = deliveryString
        dateLabel.text = dateString
        timeLabel.text = timeString
        donation3View.isHidden = boolString
        if(donation3View.isHidden == false)
        {
            confettiView = SAConfettiView(frame: self.view.bounds)
            self.view.addSubview(confettiView)
            confettiView.type = .Confetti
            
            confettiView.startConfetti()
        
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(onTick), userInfo: nil, repeats: true)

        }
    }
    
    @objc func onTick()
    {
        if (timeLeft == 0)
        {
            timer?.invalidate()
            timer = nil
            confettiView.stopConfetti()
            confettiView.isUserInteractionEnabled = false
        }
        else
        {
            timeLeft -= 1
        }
    }
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "DonationOverview"{
        let vc = segue.destination as? DonateTab1OverviewSupermarket
        vc?.nameDonateur = "Voedselbank Eindhoven"
        vc?.dateDonation = dateString
        vc?.timeDonation = timeString
        vc?.deliveryDonation = deliveryString
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
    
}
