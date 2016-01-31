//
//  ViewController.swift
//  calculator
//
//  Created by Jitendra Gaur on 29/01/16.
//  Copyright © 2016 Jitendra Gaur. All rights reserved.
//

import UIKit
import AVFoundation


class ViewController: UIViewController {
    
    enum Operation: String {
        case Devide = "/"
        case Multiply = "*"
        case Substract = "-"
        case Add = "+"
        case Empty = "Empty"
    }
    
    @IBOutlet weak var lblDisplay:UILabel!
    
    var btnKeyPressedSound:AVAudioPlayer!
    var btnClearKeyPressedSound: AVAudioPlayer!
    
    var runningNumber = ""
    var leftValStr = ""
    var rightValStr = ""
    var currentOperation: Operation = Operation.Empty
    var result = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let numberKeySoundpath = NSBundle.mainBundle().pathForResource("keypress", ofType: "mp3")
        let numberKeySoundUrl = NSURL(fileURLWithPath: numberKeySoundpath!)
        
        let clearKeySoundPath = NSBundle.mainBundle().pathForResource("emptytrash", ofType: "aif")
        let clearKeySoundUrl = NSURL(fileURLWithPath: clearKeySoundPath!)
        
        
        do {
            try btnKeyPressedSound = AVAudioPlayer(contentsOfURL: numberKeySoundUrl)
            btnKeyPressedSound.prepareToPlay()
            
            try btnClearKeyPressedSound = AVAudioPlayer(contentsOfURL: clearKeySoundUrl)
            btnClearKeyPressedSound.prepareToPlay()
            
        } catch let error as NSError {
            print(error.debugDescription)
        }
        
    }
    
    
    @IBAction func numberPressed(btn: UIButton!) {
        playSound(btnKeyPressedSound)
        runningNumber += "\(btn.tag)"
        lblDisplay.text = runningNumber
    }
    
    @IBAction func onACKeyPressed(btn: UIButton!) {
        playSound(btnClearKeyPressedSound)
        
        runningNumber = ""
        leftValStr = ""
        rightValStr = ""
        currentOperation = Operation.Empty
        result = ""
        lblDisplay.text = "0"
                
    }
    
    @IBAction func onDevideKeyPressed(sender: AnyObject) {
        arithmeticOperation(Operation.Devide)
    }
    
    @IBAction func onMultiplyKeyPressed(sender: AnyObject) {
        arithmeticOperation(Operation.Multiply)
    }
    
    @IBAction func onSubstractKeyPressed(sender: AnyObject) {
        arithmeticOperation(Operation.Substract)
    }
    
    @IBAction func onAddKeyPressed(sender: AnyObject) {
        arithmeticOperation(Operation.Add)
    }
    
    @IBAction func onEqualKeyPressed(sender: AnyObject) {
        arithmeticOperation(currentOperation)
    }
    
    
    func arithmeticOperation(operationType:Operation) {
        playSound(btnKeyPressedSound)
        
        if currentOperation !=  Operation.Empty {
            //Run some math
            
            if runningNumber != "" {
                rightValStr = runningNumber
                runningNumber = ""
                
                if currentOperation == Operation.Multiply {
                    result = "\(Double(leftValStr)! * Double(rightValStr)!)"
                } else if currentOperation == Operation.Add {
                    result = "\(Double(leftValStr)! + Double(rightValStr)!)"
                } else if currentOperation == Operation.Substract {
                    result = "\(Double(leftValStr)! - Double(rightValStr)!)"
                } else if currentOperation == Operation.Devide {
                    result = "\(Double(leftValStr)! / Double(rightValStr)!)"
                }
                
                leftValStr = result
                lblDisplay.text = String(format: "%g", Double(result)!)
            }
            currentOperation = operationType
            
        } else {
            //This is first time
            leftValStr = runningNumber
            runningNumber = ""
            currentOperation = operationType
        }
    }
    
    func playSound(sound:AVAudioPlayer) {
        if sound.playing {
            sound.stop()
        }
        sound.play()
    }
    
    
    
    
    
}

