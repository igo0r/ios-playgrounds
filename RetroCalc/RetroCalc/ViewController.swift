//
//  ViewController.swift
//  RetroCalc
//
//  Created by Igor Lantushenko on 30/01/2017.
//  Copyright © 2017 Igor Lantushenko. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    var btnSound: AVAudioPlayer!
    @IBOutlet weak var resultLabelView: UILabel!
    
    var currentOperation: Operations = Operations.Empty
    
    enum Operations: String {
        case Divide = "/"
        case Multiply = "*"
        case Add = "+"
        case Subtract = "-"
        case Empty = ""
        case Equal = "="
    }
    
    var firstNumber: String = ""
    var secondNumber: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let path = Bundle.main.path(forResource: "btn", ofType: "wav")
        let soundUrl = URL.init(fileURLWithPath: path!)
        
        do {
            try btnSound = AVAudioPlayer(contentsOf: soundUrl)
            btnSound.prepareToPlay()
        } catch let err as NSError {
            print(err.debugDescription)
        }
        
        resultLabelView.text = "0"
    }
    
    @IBAction func numberPressed(sender: UIButton){
        playSound()
        
        if currentOperation != Operations.Empty && firstNumber != ""{
            secondNumber += String(sender.tag)
            resultLabelView.text = secondNumber
        } else {
            firstNumber += String(sender.tag)
            resultLabelView.text = firstNumber
        }
    }
    
    @IBAction func resetPressed(sender: UIButton){
        playSound()
        
        resultLabelView.text = "0"
        firstNumber = ""
        secondNumber = ""
        currentOperation = Operations.Empty
    }
    
    @IBAction func addPressed(sender: UIButton){
        optionPressed(operation: Operations.Add)
    }
    
    @IBAction func dividePressed(sender: UIButton){
        optionPressed(operation: Operations.Divide)
    }
    
    @IBAction func equalPressed(sender: UIButton){
        optionPressed(operation: Operations.Equal)
    }
    
    @IBAction func multiplyPressed(sender: UIButton){
        optionPressed(operation: Operations.Multiply)
    }
    
    @IBAction func subtractPressed(sender: UIButton){
        optionPressed(operation: Operations.Subtract)
    }
    
    func optionPressed(operation: Operations){
        playSound()
        var result: Double = 0.0
        if currentOperation != Operations.Empty && secondNumber != ""{
            let labelText = resultLabelView.text!
            switch currentOperation {
            case Operations.Add:
                result = Double(firstNumber)! + Double(labelText)!
            case Operations.Subtract:
                result = Double(firstNumber)! - Double(labelText)!
            case Operations.Divide:
                result = Double(firstNumber)! / Double(labelText)!
            case Operations.Multiply:
                result = Double(firstNumber)! * Double(labelText)!
                break
            default: break
                    
            }
        
            resultLabelView.text = String(result)
            firstNumber = resultLabelView.text!
            secondNumber = ""
        }
        currentOperation = operation
    }
    
    func playSound() {
        if btnSound.isPlaying {
            btnSound.stop()
        }
        
        btnSound.play()
    }


}

