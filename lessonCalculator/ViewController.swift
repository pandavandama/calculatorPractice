//
//  ViewController.swift
//  lessonCalculator
//
//  Created by Константин Кифа on 08.06.2022.
//

import UIKit


class ViewController: UIViewController {
    
    
    
    @IBOutlet weak var stackView4: UIStackView!
    
    var actualNumber="0"
    var oldNumber="0"
    var isNext = false
    var firstOperation = true
    
    var currentOperation: Int?
    
    @IBOutlet var calcButtonsCollection: [UIButton]!
    
    
    @IBOutlet weak var displayNumbersLabel: UILabel!
    
    

    @IBOutlet weak var mainStackViewHeight: NSLayoutConstraint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        mainStackViewHeight.constant = (calcButtonsCollection[0].frame.size.width * 5) + (stackView4.spacing * 4) - 25
        print(mainStackViewHeight.constant)
        
        for button in calcButtonsCollection{
            button.layer.cornerRadius = calcButtonsCollection[0].frame.size.width / 2 - 3
//            button.clipsToBounds
print(            button.layer.cornerRadius
)//            if (button.tag = 0){
//                button.layer.wid
//            }
            print(calcButtonsCollection[0].frame.size.width)
            print(calcButtonsCollection[0].frame.size.height)
        }
    }
    
    
    
    
    @IBAction func calcActionButtonsFunction(_ sender: UIButton) {
        operationLogic(sender)
//        renderNumbers(,label: displayNumbersLabel)
        
        
    }
    
    func operationLogic(_ sender: UIButton){
        
        switch sender.tag{
        case 0...9: writeNumber(number: sender.tag)
            
        case 11...15: operationNumbers(operationIndex: sender.tag)
        case 20: currentOperation != nil ? equalOperation() : print("error")
        case 21: clear()
        case 22: modelChange()
        default:
            print("error")
        }
    }
    
    func writeNumber(number: Int){
        
//        if actualNumber != "0" && currentOperation == nil{
//            actualNumber = String(number)
//        }
        if (currentOperation == nil && oldNumber != "0"){
            actualNumber = "0"
        }
        
        
        if actualNumber == "0" || displayNumbersLabel.text == oldNumber {
            actualNumber = String(number)
        }else{
            actualNumber += String(number)
        }
        renderNumbers(number: actualNumber, label: displayNumbersLabel)
    }
    
    func renderNumbers(number: String,label: UILabel){
        label.text = number
    }
    
    func operationNumbers(operationIndex: Int){
        if firstOperation{
            currentOperation = operationIndex
            firstOperation = false
        }else{
            equalOperation()
            currentOperation = operationIndex
        }
        isNext = true
        oldNumber = actualNumber
        
        
    }

    func equalOperation(){
        
        
        
        switch currentOperation!{
        case 11: actualNumber = String(Int(oldNumber)!/Int(actualNumber)!)
        case 12: actualNumber = String(Int(oldNumber)! * Int(actualNumber)!)
        case 13: actualNumber = String(Int(oldNumber)! - Int(actualNumber)!)
        case 14: actualNumber = String(Int(oldNumber)! + Int(actualNumber)!)
        case 15: actualNumber = String(Int(oldNumber)! % Int(actualNumber)!)
        default:
            print("error")
        }
        renderNumbers(number: actualNumber, label: displayNumbersLabel)
        currentOperation = nil
        firstOperation = true
        isNext = false
    }
    func clear(){
        actualNumber="0"
        oldNumber="0"
        isNext = false
        firstOperation = true
        currentOperation = nil
        renderNumbers(number: "0", label: displayNumbersLabel)
    }
    func modelChange(){
        
        if actualNumber == "0" {return}
        
        if Int(actualNumber)! > 0{
            actualNumber = "-" + actualNumber
        }else{
            actualNumber.remove(at: actualNumber.startIndex)        }
        renderNumbers(number: actualNumber, label: displayNumbersLabel)
    }
}




