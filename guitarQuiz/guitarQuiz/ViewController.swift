//
//  ViewController.swift
//  guitarQuiz
//
//  Created by MayurBeldar on 9/5/17.
//  Copyright © 2017 MayurBeldar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    
    @IBOutlet var b04: UIImageView!
    @IBOutlet var b03: UIImageView!
    @IBOutlet var b02: UIImageView!
    @IBOutlet var b01: UIImageView!
    
    @IBOutlet var b14: UIImageView!
    @IBOutlet var b13: UIImageView!
    @IBOutlet var b12: UIImageView!
    @IBOutlet var b11: UIImageView!
    
    @IBOutlet var b24: UIImageView!
    @IBOutlet var b23: UIImageView!
    @IBOutlet var b22: UIImageView!
    @IBOutlet var b21: UIImageView!
    
    @IBOutlet var b34: UIImageView!
    @IBOutlet var b33: UIImageView!
    @IBOutlet var b32: UIImageView!
    @IBOutlet var b31: UIImageView!
    
    @IBOutlet var b44: UIImageView!
    @IBOutlet var b43: UIImageView!
    @IBOutlet var b42: UIImageView!
    @IBOutlet var b41: UIImageView!
    
    
    
    @IBOutlet var image: UIImageView!
    @IBOutlet var Button1: UIButton!
    var ButtonOrigin: CGPoint!
    var chordsFingerArray : [UIImageView]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addPanGesture(view: Button1)
        ButtonOrigin = Button1.frame.origin
        
       // print(image.frame.debugDescription)
        print(Button1.frame.debugDescription)
        print(ButtonOrigin)
        
         chordsFingerArray = [b04,b03,b02,b01,b14,b13,b12,b11,b24,b23,b22,b21,b34,b33,b32,b31,b44,b43,b42,b41]
        
        for element in chordsFingerArray{
            element.isHidden = true;
        }
        
    }

    
    func assignChordToView(){
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func addPanGesture(view: UIView){
        view.bringSubview(toFront: view)
        let pan = UIPanGestureRecognizer(target: self, action: #selector(ViewController.handlePan(sender:)))
        view.addGestureRecognizer(pan)
        view.removeGestureRecognizer(pan)
    }
    
    @objc func handlePan(sender: UIPanGestureRecognizer){
        let buttonView = sender.view
        let translation = sender.translation(in: view)
        
        switch sender.state {
        case .began , .changed:
            //add the translation
            Button1.center = CGPoint(x: (buttonView?.center.x)! + translation.x, y: (buttonView?.center.y)! + translation.y)
            //reset the translation value to zero
            sender.setTranslation(CGPoint.zero, in: view)
        case .ended:
           
            
   print(Button1.frame.debugDescription)
            
            if image.frame.intersects(Button1.frame){
                
                UIView.animate(withDuration: 0.4, animations:
                {
                  self.Button1.tintColor = UIColor.red
                }
                )
                
            }
            UIView.animate(withDuration: 0.4, animations:
                {
                    self.Button1.frame.origin = self.ButtonOrigin
            }
                
            )
            print(Button1.frame.debugDescription)
            
        default: break;
        }
        
    }
}

