//
//  ViewController.swift
//  simple-calc
//
//  Created by Anirudh Subramanyam on 10/16/18.
//  Copyright © 2018 Anirudh Subramanyam. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var calculation: [String] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    //display all calculations leading to result
    @IBOutlet weak var trackOp: UITextField!
    //result text field
    @IBOutlet weak var display: UITextField!
    var operations = ["/", "*", "-", "+", "%", "count", "avg", "fact"]
    let storage = UserDefaults.standard
    
    
    //gets input and handles separation of operation, forming decimals
    @IBAction func input(_ sender: UIButton!) {
        let value:String = (sender.titleLabel?.text)!
        if (operations.contains(value)){
            calculation.append(display.text!)
            calculation.append(value)
            display.text = ""
        }else {
         display.text = display.text! +  value
        }
        trackOp.text = trackOp.text! + " " + value
    }
    
    //after "=" is pressed
    @IBAction func calculate(_ sender: Any) {
        if(display.text != ""){
            calculation.append(display.text!)
        }
        var result:Double = 0
        for i in 0...calculation.count - 1 {
            switch calculation[i]{
            case "+":
                result = Double(calculation[i - 1])! + Double(calculation[i + 1])!
            case "-":
                result = Double(calculation[i - 1])! - Double(calculation[i + 1])!
            case "/":
                result = Double(calculation[i - 1])! / Double(calculation[i + 1])!
            case "*":
                result = Double(calculation[i - 1])! * Double(calculation[i + 1])!
            case "%":
                let val1 = Double(calculation[i - 1])!
                let val2 = Double(calculation[i + 1])!
                result = val1 - Double(Int(val1) / Int(val2)) * val2
            case "count":
                result = Double(calculation.count - (calculation.count / 2))
                break
            case "avg":
                result = average(calculation)
                break
            case "fact":
                result = calculation.count > 2 ? -1 : fact(calculation[0]) // -1 if not valid
                break
            default:
                break
            }
        }
        display.text = String(result)
        let historyText = trackOp.text! + " = \(String(result))"
        var history = storage.object(forKey: "History") as? [String] ?? [String]()
        history.append(historyText)
        storage.set(history, forKey:"History")
        calculation.removeAll()
    }
    
    //after "C" is pressed
    @IBAction func clear(_ sender: UIButton) {
        calculation.removeAll()
        display.text = ""
        trackOp.text = ""
    }
    
    //caclulate average
    func average(_ arr:[String]) -> Double {
        var sum:Double = 0
        for i in 0...arr.count - 1 {
            sum += Double(arr[i]) != nil ? Double(arr[i])! : 0
        }
        return sum / Double(arr.count - (arr.count / 2))
    }
    
    //caclulate factorial
    func fact(_ i:String) -> Double {
        let num = Double(i)! //not doing for decimals
        var result:Double = 1
        if (num > 0) {
            for j in stride(from: 1.0, to: num + 1, by: 1.0) {
                result *= j
            }
        }else if (num < 0){
            result = 0
        }
        return result
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        let destination = segue.destination as! HistoryViewController
//        destination.setHistory(incoming: history)
//    }
}

