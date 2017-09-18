//
//  ViewController.swift
//  ImageRecognizerApp
//
//  Created by MayurBeldar on 9/18/17.
//  Copyright © 2017 MayurBeldar. All rights reserved.
//

import UIKit
import AVKit
import Vision
import CoreML

class ViewController: UIViewController, AVCaptureVideoDataOutputSampleBufferDelegate {

    @IBOutlet var ObjectName: UILabel!
    @IBOutlet var camView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //start the camera
        let captureSession = AVCaptureSession()
        guard let captureDevice = AVCaptureDevice.default(for: .video) else {return}
        guard let input = try? AVCaptureDeviceInput(device: captureDevice)else {return}
        captureSession.addInput(input)
        
        captureSession.startRunning()
    
        let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        self.camView.layer.addSublayer(previewLayer)
        previewLayer.frame = camView.frame
        print("dsffds")
        let dataOutput = AVCaptureVideoDataOutput()
        dataOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "VideoQueue"))
        captureSession.addOutput(dataOutput)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
 
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        //print("Hey! Camera was able to capture frame @",Date())
        
        guard let pixelBuffer: CVPixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else {return}
        
        guard let model = try? VNCoreMLModel(for: Resnet50().model)else {return}
        
        let request = VNCoreMLRequest(model: model){
            (finishedReq,err) in
            
            let result = finishedReq.results as! [VNClassificationObservation]
            print(result[0].identifier, result[0].confidence)
            DispatchQueue.main.async {
                self.ObjectName.text = result.first?.identifier
            }
            
        }
        
        try? VNImageRequestHandler(cvPixelBuffer: pixelBuffer, options: [:]).perform([request])
        
    }

}

