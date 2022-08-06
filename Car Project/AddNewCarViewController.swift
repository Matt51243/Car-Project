//
//  AddNewCarViewController.swift
//  Car Project
//
//  Created by Matthew on 8/5/22.
//

import UIKit

var carInfo: CarInfo?

class AddNewCarViewController: UIViewController {

    @IBOutlet var saveButton: UIButton!
    @IBOutlet var YearTextFeild: UITextField!
    @IBOutlet var MakeTextFeild: UITextField!
    @IBOutlet var ModelTextFeild: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupToolbar()
        
        //disables the save button depending on if textfield is filled out
        [YearTextFeild, MakeTextFeild, ModelTextFeild].forEach({ $0?.addTarget(self, action: #selector(editingChanged), for: .editingChanged)})
    }
    
    override func viewWillAppear(_ animated: Bool) {
        saveButton.isEnabled = false
    }
    
    //When you tap the cancel button it makes it go back to the Main View
    @IBAction func CancelButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    //Function that checks if all the texfeilds are filled out
    @objc func editingChanged(_ textField: UITextField) {
        if YearTextFeild.hasText && MakeTextFeild.hasText && ModelTextFeild.hasText == true {
            saveButton.isEnabled = true
        } else {
            saveButton.isEnabled = false
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let yearString = YearTextFeild.text
        let year = Int(yearString ?? "")
        let make = MakeTextFeild.text
        let model = ModelTextFeild.text
        
        carInfo = CarInfo(year: year ?? 2000, Make: make!, Model: model!)
    }
    
    //Function that adds the "Done" button to dismiss the keyboard
    func setupToolbar() {
        let bar = UIToolbar()
        let doneBtn = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(dismissMyKeyboard))
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        bar.items = [flexSpace, flexSpace, doneBtn]
        bar.sizeToFit()
        YearTextFeild.inputAccessoryView = bar
        MakeTextFeild.inputAccessoryView = bar
        ModelTextFeild.inputAccessoryView = bar
    }
    
    @objc func dismissMyKeyboard() {
        view.endEditing(true)
    }
}
