//
//  ViewController.swift
//  retroCalculator
//
//  Created by 太田修 on 2016/02/07.
//  Copyright © 2016年 太田修. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    enum Operation: String {
        case Divide = "/"
        case Multiply = "*"
        case Subtract = "-"
        case Add = "+"
        case Empty = "Empty"
    }
    
    @IBOutlet weak var outputLbl: UILabel!
    
    var btnSound: AVAudioPlayer!
    
    var runningNumber = ""
    var leftValStr = ""
    var RightValStr = ""
    var currentOperation: Operation = Operation.Empty
    var result = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let path = NSBundle.mainBundle().pathForResource("btn", ofType: "wav")
        let soundUrl = NSURL(fileURLWithPath: path!)
        
        do {
            try btnSound = AVAudioPlayer(contentsOfURL: soundUrl)
            btnSound.prepareToPlay()
        } catch let err as NSError {
            print(err.debugDescription)
        }
    }

    @IBAction func numberPressed(btn: UIButton!) {
        playsound()
        
        runningNumber += "\(btn.tag)"
        outputLbl.text = runningNumber
    }
    
    @IBAction func onDividePressed(sender: AnyObject) {
        processOperation(Operation.Divide)
    }
    
    @IBAction func onMultiplyPressed(sender: AnyObject) {
        processOperation(Operation.Multiply)
    }
    
    @IBAction func onSubtractPressed(sender: AnyObject) {
        processOperation(Operation.Subtract)
    }
    
    @IBAction func onAddPressed(sender: AnyObject) {
        processOperation(Operation.Add)
    }
    
    @IBAction func onEqualPressed(sender: AnyObject) {
        processOperation(currentOperation)
    }
    
    func processOperation(op: Operation) {
        playsound()
        
        if currentOperation != Operation.Empty {
            // Run some math
            
            if runningNumber != "" {

                RightValStr = runningNumber
                runningNumber = ""
                
                if currentOperation == Operation.Multiply {
                    result = "\(Double(leftValStr)! * Double(RightValStr)!)"
                } else if currentOperation == Operation.Divide {
                    result = "\(Double(leftValStr)! / Double(RightValStr)!)"
                } else if currentOperation == Operation.Subtract {
                    result = "\(Double(leftValStr)! - Double(RightValStr)!)"
                } else if currentOperation == Operation.Add {
                    result = "\(Double(leftValStr)! + Double(RightValStr)!)"
                }
                
                leftValStr = result
                outputLbl.text = result
                
            }

            
            currentOperation = op
            
        } else {
            // This is the first time an operator has been pressed
            leftValStr = runningNumber
            runningNumber = ""
            currentOperation = op
            
        }
    }
    
    func playsound() {
        if btnSound.playing {
            btnSound.stop()
        }
        
        btnSound.play()
    }
    
}

