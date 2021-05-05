//
//  DonateTab2Supermarket.swift
//  DUO app
//
//  Created by Student on 10/10/2019.
//  Copyright © 2019 Angel & Esmee. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

protocol SendSelectedCharity {
    func sendSelectedCharityForward(selectedCharity: String)
}

class DonateTab2Supermarket: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    @IBOutlet weak var theMap: MKMapView!
    @IBOutlet weak var donateButton: UIButton!
    @IBOutlet weak var charityName: UILabel!
    @IBOutlet weak var charityAddress: UILabel!
    @IBOutlet weak var charityPhone: UILabel!
    @IBOutlet weak var charityDelivery: UILabel!
    @IBOutlet weak var charityInfoView: UIView!
    
    var location: CLLocation!
    let locationManager = CLLocationManager()
    let charityMarker = MKPointAnnotation()
    let charityMarker2 = MKPointAnnotation()
    var delegate: SendSelectedCharity? = nil
    var selectedCharity : String!
    var charities = [Charity]()
    var selectedCharityIndex : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        theMap.layer.cornerRadius = 10
        theMap.layer.borderWidth = 1
        theMap.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)

        // Do any additional setup after loading the view.
        charityMarker.title = "Dierenopvang Doornakker"
        charityMarker.coordinate = CLLocationCoordinate2D(latitude: 51.439500, longitude: 5.523450)
        charityMarker2.title = "Voedselbank Eindhoven"
        charityMarker2.coordinate = CLLocationCoordinate2D(latitude: 51.436450, longitude: 5.497690)
        let pinAnnotationView = MKPinAnnotationView(annotation: charityMarker2, reuseIdentifier: "pin")
        let btn = UIButton(type: .detailDisclosure)
        pinAnnotationView.rightCalloutAccessoryView = btn
        theMap.addAnnotation(charityMarker)
        theMap.addAnnotation(charityMarker2)
        donateButton.isEnabled = false
        donateButton.setTitleColor(UIColor.gray, for: .disabled)
        self.theMap.delegate = self
        zoomIn()
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        selectedCharity = view.annotation?.title!
        getCharityInfo(selectedCharityName: selectedCharity)
        donateButton.isEnabled = true
        donateButton.setTitleColor(UIColor.white, for: .disabled)
    }

//    GET CORRECT DATA FROM THE JSON FILE
    func getCharityInfo(selectedCharityName: String){
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
                    
            if let i = self.charities.firstIndex(where: {
                $0.name == selectedCharityName })
            {
                self.selectedCharityIndex = i
            }
            
            
            DispatchQueue.main.async {
                self.charityName.text = self.charities[self.selectedCharityIndex].name
                self.charityAddress.text = self.charities[self.selectedCharityIndex].address
                self.charityPhone.text = self.charities[self.selectedCharityIndex].phonenr
                self.charityDelivery.text = self.charities[self.selectedCharityIndex].deliverymethod
                self.charityInfoView.isHidden = false
            }
            
        }.resume()
        
    }
    
    func zoomIn() {
        let span = MKCoordinateSpan.init(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let region = MKCoordinateRegion.init(center: (locationManager.location?.coordinate)!, span: span)
        theMap.setRegion(region, animated: true)
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
