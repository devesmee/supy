//
//  QRViewController.swift
//  DUO app
//
//  Created by Student on 10/10/19.
//  Copyright © 2019 Angel & Esmee. All rights reserved.
//

import UIKit
import AVFoundation


class QRViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {

    @IBOutlet var CameraView: UIView!
        
    weak var delegate: QRVCDelegate?
            
    var video = AVCaptureVideoPreviewLayer()
     
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        CameraView.layer.cornerRadius = 10
        CameraView.layer.borderWidth = 1
        CameraView.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        
        // Creating session.
        let session = AVCaptureSession()
        
        // Define capture device
        guard let captureDevice = AVCaptureDevice.default(for: AVMediaType.video) else {
            print("Failed to access camera.")
            return
        }
        
        do
        {
            let input = try AVCaptureDeviceInput(device: captureDevice)
            session.addInput(input)
        }
        catch
        {
            print("ERROR")
        }
        
        let output = AVCaptureMetadataOutput()
        session.addOutput(output)
        
        output.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
        
        output.metadataObjectTypes = [AVMetadataObject.ObjectType.qr]
        
        session.startRunning()
        
        video = AVCaptureVideoPreviewLayer(session: session)
        
        // Resize the live view camera.
        CameraView.layer.masksToBounds = true
        
        video.videoGravity = AVLayerVideoGravity.resizeAspectFill
        video.frame = CameraView.layer.bounds
        CameraView.layer.addSublayer(video)
        
        DispatchQueue.main.async {
            self.video.frame = self.CameraView.bounds
        }
        
    }
    
    // Read data.
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        
//        print(metadataObjects.count)
        
        let scannedItem = Item(name: "")
        
        if metadataObjects != nil && metadataObjects.count != 0{
            if let object = metadataObjects[0] as? AVMetadataMachineReadableCodeObject{
                if object.type == AVMetadataObject.ObjectType.qr
                {
                    let alert = UIAlertController(title: "QR Code", message: object.stringValue, preferredStyle: .alert)
                    let alertAddAction = UIAlertAction(title: "Add", style: .default){action in
                        scannedItem.Name = object.stringValue!
                        Items.shared.AddItem(item: scannedItem)
                        print("::::::::::::::::::::DEBUG:::::::::::::::::::: \n SCANNED ITEM NAME ====== \(scannedItem.Name) \n ********************************************")
                        print("::::::::::::::::::::DEBUG:::::::::::::::::::: \n NR OF ITEMS SCANNED ====== \(Items.shared.ListItems.count) \n ********************************************")
                        self.delegate?.scanned(sender: self)
                    }
                    let alertCancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
                    alert.addAction(alertCancelAction)
                    alert.addAction(alertAddAction)
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be received
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
