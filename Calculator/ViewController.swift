//
//  ViewController.swift
//  Calculator
//
//  Created by yanyin on 28/02/2017.
//  Copyright © 2017 yanyin. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{

    @IBOutlet weak var display: UILabel!
    
    var userIsInMiddleOfTypingANumber: Bool = false
    
    var brain = CalculatorBrain()
    
    
    @IBAction func appendDigit(_ sender: UIButton) {
        let digit = sender.currentTitle!
        if userIsInMiddleOfTypingANumber {
            if display.text == "π"{
                display.text = String(M_PI)
            }else {
                display.text = display.text! + digit
            }
        }else{
            display.text = digit
            userIsInMiddleOfTypingANumber = true
        }
        
        print("digit = \(digit)")
        
    }
    
    @IBAction func operate(_ sender: UIButton) {
        if userIsInMiddleOfTypingANumber {
            enter()
        }
        if let operation = sender.currentTitle{
            if let result = brain.performOperand(symbol: operation){
                displayValue = result
            }else{
                displayValue = 0
            }
        }
    }
    
    
    @IBAction func enter() {
        userIsInMiddleOfTypingANumber = false
        if let result = brain.pushOperand(operand: displayValue){
            displayValue = result
        }else {
            displayValue = 0
        }
    }
    
    var displayValue: Double{
        get{
            if display.text == "π" {
                return Double(M_PI)
            }else{
                return NumberFormatter().number(from: display.text!)!.doubleValue
            }
        }
        set{
           display.text = "\(newValue)"
            userIsInMiddleOfTypingANumber = false
        }
    }
}

