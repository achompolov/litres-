//
//  ViewController.swift
//  litres?
//
//  Created by Atanas Chompolov on 6.06.18.
//  Copyright © 2018 Atanas Chompolov. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var tripPrice: UILabel!
    @IBOutlet weak var tripDistance: UITextField!
    @IBOutlet weak var fuelConsumption: UITextField!
    @IBOutlet weak var fuelType: UITextField!
    
    var fuelTypeParameter = ""
    // Specify type for pickerviews
    let fuelTypes = ["gasoline", "diesel"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Create inputs as pickerviews
        let inputs: [UITextField] = [fuelType]
        for (tag, type) in inputs.enumerated() {
            textToPickerView(textInput: type, tag: tag)
        }
        
        
        // Hide keyboard on tap outside
            //Looks for single or multiple taps.
            let tap: UITapGestureRecognizer =
                UITapGestureRecognizer(target: self, action: #selector(ViewController.dismissKeyboard))
            //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
            tap.cancelsTouchesInView = false
            view.addGestureRecognizer(tap)
    }
    
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func textToPickerView(textInput: UITextField, tag: Int) {
        let textInputPickerView = UIPickerView()
        textInputPickerView.delegate = self
        textInputPickerView.tag = tag
        textInput.inputView = textInputPickerView
    }

    @IBAction func getFuelPrice(_ sender: Any) {
        switch (tripDistance.text?.isEmpty, fuelType.text?.isEmpty, fuelConsumption.text?.isEmpty) {
        case (true, _, true):
            tripPrice.text = "provide trip distance && fuel consumption info"
        case (true, _, false):
            tripPrice.text = "provide trip distance info"
        case (false, _, true):
            tripPrice.text = "provide fuel consumption info"
        case (false, _, false):
            let tripD: Double = comaToDot(for: tripDistance.text!)
            let fuelC: Double = comaToDot(for: fuelConsumption.text!)
            let date = Date()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let today = dateFormatter.string(from: date)
            print(today)
            
            let tripConsumption = (tripD / 100) * fuelC
            
            FueloRequestManager.sendRequest(fuel: fuelType.text!, date: today)
            let tripP = 2.26 * tripConsumption
            //print("Consumption:\(Int(tripConsumption))\nTrip price:\(tripP)")
            tripPrice.text = "\(String(format: "%.2f", tripP)) lv"
        default:
            break
        }

        self.resignFirstResponder()
    }
    
    func comaToDot(for number: String) -> Double{
        let number = NumberFormatter().number(from: number)
        let doubleValue = Double(truncating: number!)
        
        //print(doubleValue)
        return doubleValue
    }
    
    // Creating PickerViews using Delegates
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView.tag {
        case 0:
            return fuelTypes.count
        default:
            break
        }
        
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView.tag {
        case 0:
            return fuelTypes[row]
        default:
            break
        }
        
        return nil
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView.tag {
        case 0:
            fuelType.text = fuelTypes[row]
        default:
            break
        }
    }
    
}

