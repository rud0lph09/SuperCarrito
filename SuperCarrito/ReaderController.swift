//
//  ReaderController.swift
//  SuperCarrito
//
//  Created by Rodolfo Castillo on 14/11/15.
//  Copyright © 2015 Rodolfo Castillo. All rights reserved.
//

import AVFoundation
import UIKit


class ReaderController: UIView, AVCaptureMetadataOutputObjectsDelegate {
    var captureSession: AVCaptureSession!
    var previewLayer: AVCaptureVideoPreviewLayer!
    internal var readData: UILabel!
    let ScreenSize: CGRect = UIScreen.mainScreen().bounds
    var screenHeight: CGFloat!
    var screenWidth: CGFloat!
    
    @IBOutlet weak var SuperViewController: ShoppingCartController!
    
    func scannerDidLoad() {
        self.screenWidth = ScreenSize.width
        self.screenHeight = ScreenSize.height
        self.readData = UILabel(frame: CGRectMake(0, 0, screenWidth, 21))
        self.readData.backgroundColor = UIColor.whiteColor()
        self.readData.alpha = 0.7
        readData.center = CGPointMake(screenWidth/2, screenHeight - 21)
        readData.textAlignment = NSTextAlignment.Center
        readData.text = ""
        self.backgroundColor = UIColor.blackColor()
        captureSession = AVCaptureSession()
        
        let videoCaptureDevice = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
        let videoInput: AVCaptureDeviceInput
        
        do {
            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
        } catch {
            return
        }
        
        if (captureSession.canAddInput(videoInput)) {
            captureSession.addInput(videoInput)
        } else {
            failed();
            return;
        }
        
        let metadataOutput = AVCaptureMetadataOutput()
        
        if (captureSession.canAddOutput(metadataOutput)) {
            captureSession.addOutput(metadataOutput)
            
            metadataOutput.setMetadataObjectsDelegate(self, queue: dispatch_get_main_queue())
            metadataOutput.metadataObjectTypes = [AVMetadataObjectTypeQRCode, AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypePDF417Code]
        } else {
            failed()
            return
        }
        
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession);
        previewLayer.frame = self.layer.bounds;
        previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
        self.layer.addSublayer(previewLayer);
        self.addSubview(readData)
        captureSession.startRunning();
    }
    
    func failed() {
        let ac = UIAlertController(title: "Scanning not supported", message: "Your device does not support scanning a code from an item. Please use a device with a camera.", preferredStyle: .Alert)
        ac.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
//        self.addSubview(ok)(ac, animated: true, completion: nil)
        captureSession = nil
    }
    
//    override func viewWillAppear(animated: Bool) {
//        super.viewWillAppear(animated)
//        
//        if (captureSession?.running == false) {
//            captureSession.startRunning();
//        }
//    }
//    
//    override func viewWillDisappear(animated: Bool) {
//        super.viewWillDisappear(animated)
//        
//        if (captureSession?.running == true) {
//            captureSession.stopRunning();
//        }
//    }
    
    func captureOutput(captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [AnyObject]!, fromConnection connection: AVCaptureConnection!) {
        captureSession.stopRunning()
        
        if let metadataObject = metadataObjects.first {
            let readableObject = metadataObject as! AVMetadataMachineReadableCodeObject;
            
            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
            foundCode(readableObject.stringValue);
        }
        
//        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func foundCode(code: String) {
        print(code)
        if (Double(code) != nil) {
            self.readData.text = code
            self.captureSession.stopRunning()
            self.SuperViewController.hideScanner()
            self.SuperViewController.addProductButton.setTitle("Add", forState: UIControlState.Normal)
        }
        else {
            print("Wasnt a BarCode")
            self.captureSession.stopRunning()
            self.SuperViewController.hideScanner()
            self.SuperViewController.addProductButton.setTitle("Add", forState: UIControlState.Normal)
        }
        

//        self.performSegueWithIdentifier("connect", sender: self)
    }
//    
//    override func prefersStatusBarHidden() -> Bool {
//        return true
//    }
//    
//    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
//        return .Portrait
//    }
//    
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        if (segue.identifier == "connect") {
//            //Checking identifier is crucial as there might be multiple
//            // segues attached to same view
//            let detailVC = segue.destinationViewController as! ShoppingCartController;
//            detailVC.objectID = self.readData.text
//        }
//    }
}


