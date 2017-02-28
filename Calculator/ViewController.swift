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
    
    @IBAction func appendDigit(_ sender: UIButton) {
        let digit = sender.currentTitle!
        if userIsInMiddleOfTypingANumber {
//            if display.text == "π"{
//                display.text = String(M_PI)
//            }else {
                display.text = display.text! + digit
//            }
        }else{
            display.text = digit
            userIsInMiddleOfTypingANumber = true
        }
        
        print("digit = \(digit)")
        
    }
    
    @IBAction func operate(_ sender: UIButton) {
        let operation = sender.currentTitle!
        if userIsInMiddleOfTypingANumber {
            enter()
        }
        switch operation {
            case "×": performOperation{ $0 * $1 }
            case "÷": performOperation{ $1 / $0 }
            case "+": performOperation{ $0 + $1 }
            case "−": performOperation{ $1 - $0 }
            case "√": performOperation2{ sqrt($0) }
            case "sin": performOperation2{ sin($0) }
            case "cos": performOperation2{ cos($0) }
            default: break
        }
    }
    
    func performOperation(operation: (Double, Double) -> Double) {
        if operandStack.count >= 2 {
            displayValue = operation(operandStack.removeLast(), operandStack.removeLast())
            enter()
        }
    }
    
    func performOperation2(operation: (Double) -> Double) {
        if operandStack.count >= 1 {
            displayValue = operation(operandStack.removeLast())
            enter()
        }
    }
    
    var operandStack = Array<Double>()
    
    @IBAction func enter() {
        userIsInMiddleOfTypingANumber = false
        operandStack.append(displayValue)
        print("operandStack = \(operandStack)")
    }
    
    var displayValue: Double{
        get{
            return NumberFormatter().number(from: display.text!)!.doubleValue
        }
        set{
           display.text = "\(newValue)"
            userIsInMiddleOfTypingANumber = false
        }
    }
}

