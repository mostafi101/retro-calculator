//
//  ViewController.swift
//  retro-calculator
//
//  Created by Mostafijur Rahaman on 6/9/16.
//  Copyright © 2016 Mostafijur Rahaman. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    enum Operations: String{
        case Divide = "/"
        case Multiply = "*"
        case Subtract = "-"
        case Add = "+"
        case Empty = "Empty"
    }
    
    @IBOutlet weak var outputLbl: UILabel!
    
    var btnSound :AVAudioPlayer!
    
    var runningNumber = ""
    var leftNumberStr = ""
    var rightNumberStr = ""
    var currentOperation: Operations = Operations.Empty
    var result = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let path = NSBundle.mainBundle().pathForResource("btn", ofType: "wav")
        let soundURL = NSURL(fileURLWithPath: path!)
        
        do{
            try btnSound = AVAudioPlayer(contentsOfURL: soundURL)
            btnSound.prepareToPlay()
        }catch let err as NSError{
            print(err.debugDescription)
        }
    }

    @IBAction func numberPressedBtn(btn: UIButton!){
        playSound()
        
        runningNumber += "\(btn.tag)"
        outputLbl.text = runningNumber
    }
    
    @IBAction func onDividePressed(sender: AnyObject) {
        processOperation(Operations.Divide)
    }
    
    @IBAction func onMultiplicationPressed(sender: AnyObject) {
        processOperation(Operations.Multiply)
    }

    @IBAction func onSubtractionPressed(sender: AnyObject) {
        processOperation(Operations.Subtract)
    }
    
    @IBAction func onAdditionPressed(sender: AnyObject) {
        processOperation(Operations.Add)
    }
    
    @IBAction func onEqualPressed(sender: AnyObject) {
        processOperation(currentOperation)
    }
    
    func processOperation(op: Operations){
        playSound()
        
        if currentOperation != Operations.Empty{
            if runningNumber != ""{
                rightNumberStr = runningNumber
                runningNumber = ""
                
                if currentOperation == Operations.Multiply{
                    result = "\(Double(leftNumberStr)! * Double(rightNumberStr)!)"
                }else if currentOperation == Operations.Divide{
                    result = "\(Double(leftNumberStr)! / Double(rightNumberStr)!)"
                }else if currentOperation == Operations.Subtract{
                    result = "\(Double(leftNumberStr)! - Double(rightNumberStr)!)"
                }else if currentOperation == Operations.Add{
                    result = "\(Double(leftNumberStr)! + Double(rightNumberStr)!)"
                }
                
                leftNumberStr = result
                outputLbl.text = result
            }
            
            currentOperation = op
        }else{
            leftNumberStr = runningNumber
            runningNumber = ""
            currentOperation = op
        }
    }
    
    func playSound(){
        if btnSound.playing{
            btnSound.stop()
        }
        
        btnSound.play()
    }
}

