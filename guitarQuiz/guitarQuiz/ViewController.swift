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
    @IBOutlet var Button2: UIButton!
    @IBOutlet var Button3: UIButton!
    
    @IBOutlet var ScoreCard: UITextField!
    @IBOutlet var correctButton: UILabel!
    @IBOutlet var incorrectButton: UILabel!
    
    var MyArray: [(String,[UIImageView])]? = nil
    var ButtonOrigin: CGPoint!
    var ButtonOrigin2: CGPoint!
    var ButtonOrigin3: CGPoint!
    var chordsFingerArray : [UIImageView]!
    var Score = 0;
    var ansButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        Button1.setTitle("First", for: UIControlState.normal)
        Button2.setTitle("2nd", for: UIControlState.normal)
        Button3.setTitle("3rd", for: UIControlState.normal)
        addPanGesture(view: Button2)
        addPanGesture(view: Button3)
        addPanGesture(view: Button1)
        ButtonOrigin = Button1.frame.origin
        ButtonOrigin2 = Button2.frame.origin
        ButtonOrigin3 = Button3.frame.origin
        
        chordsFingerArray = [b04,b03,b02,b01,b14,b13,b12,b11,b24,b23,b22,b21,b34,b33,b32,b31,b44,b43,b42,b41]
        hideEveryChord()
       
        
        
        let chordA = [b03,b14]
        let chordB = [b12,b11,b23,b44]
        let chordC = [b21]
        
        MyArray?.append(("A",chordA as! [UIImageView]))
        MyArray?.append(("B",chordB as! [UIImageView]))
        print(chordB.count)
        MyArray = [("A",chordA as! [UIImageView]),("B",chordB as! [UIImageView]),("C",chordC as! [UIImageView])]
        
    }

        func hideEveryChord(){
            for element in chordsFingerArray{
                element.isHidden = true;
            }
            
            self.correctButton.isHidden = true;
            self.incorrectButton.isHidden = true;
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
        //view.removeGestureRecognizer(pan)
    }
    
    @objc func handlePan(sender: UIPanGestureRecognizer){
        let buttonView = sender.view
        let translation = sender.translation(in: view)
        
        switch sender.state {
        case .began , .changed:
            //add the translation
            buttonView?.center = CGPoint(x: (buttonView?.center.x)! + translation.x, y: (buttonView?.center.y)! + translation.y)
            //reset the translation value to zero
            sender.setTranslation(CGPoint.zero, in: view)
        case .ended:
            if image.frame.intersects((buttonView?.frame)!){
                UIView.animate(withDuration: 0.4, animations:
                {
                    buttonView?.tintColor = UIColor.red
                    
                    self.ansButton?.tintColor = UIColor.green
                    
                    if(self.ansButton==buttonView){
                    self.correctButton.isHidden = false;
                        self.Score = self.Score + 1
                        self.ScoreCard.text = "SCORE: " + String(self.Score)
                    }
                    else{
                        self.incorrectButton.isHidden = false;
                    }
                }
                )
            }
           
            UIView.animate(withDuration: 0.4, animations:
                {
                    if(buttonView==self.Button1){
                    buttonView?.frame.origin = self.ButtonOrigin
                    }
                    if(buttonView==self.Button2)
                    {
                        buttonView?.frame.origin = self.ButtonOrigin2
                    }
                    if(buttonView==self.Button3)
                    {
                        buttonView?.frame.origin = self.ButtonOrigin3
                    }
            }
            )
        default: break;
        }
        
    }
    func resetColors(){
        self.Button1.tintColor = UIColor.blue
        self.Button2.tintColor = UIColor.blue
        self.Button3.tintColor = UIColor.blue
    }
    @IBAction func NextButton(_ sender: UIButton) {
        
        hideEveryChord()
        resetColors()
        let random = arc4random_uniform(3)
        let mm = MyArray![Int(random)]
        let name = mm.0
        let arr = mm.1

        for element in arr{
            element.isHidden = false
        }
        
        
        let random2 = arc4random_uniform(3)
        switch Int(random2) {
        case 0:
            Button1.setTitle(name, for: UIControlState.normal)
            ansButton = Button1
            var b2title = getRandomTitle()
            while(b2title==name)
            {b2title = getRandomTitle()}
            
            var b3title = getRandomTitle()
            while(b3title==name || b3title==b2title)
            {b3title = getRandomTitle()}
            
            Button2.setTitle(b2title, for: UIControlState.normal)
            Button3.setTitle(b3title, for: UIControlState.normal)
            
        case 1:
            Button2.setTitle(name, for: UIControlState.normal)
            ansButton = Button2
            var b2title = getRandomTitle()
            while(b2title==name)
            {b2title = getRandomTitle()}
            
            var b3title = getRandomTitle()
            while(b3title==name || b3title==b2title)
            {b3title = getRandomTitle()}
            
            Button1.setTitle(b2title, for: UIControlState.normal)
            Button3.setTitle(b3title, for: UIControlState.normal)
            
        case 2:
            Button3.setTitle(name, for: UIControlState.normal)
            ansButton = Button3
            var b2title = getRandomTitle()
            while(b2title==name)
            {b2title = getRandomTitle()}
            
            var b3title = getRandomTitle()
            while(b3title==name || b3title==b2title)
            {b3title = getRandomTitle()}
            
            Button2.setTitle(b2title, for: UIControlState.normal)
            Button1.setTitle(b3title, for: UIControlState.normal)
            
        default:
            break;
        }
        
    }
    func getRandomTitle()->String{
        let arr = ["A","B","C"];
        let random = arc4random_uniform(3)
        return arr[Int(random)]
    }
}

