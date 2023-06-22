//
//  CatFormViewController.swift
//  Miaouf
//
//  Created by Pierre Sabard on 22/06/2023.
//

import UIKit

class CatFormViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardAppear(_:)), name: UIViewController.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDisappear(_:)), name: UIViewController.keyboardWillHideNotification, object: nil)
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var genderSegmented: UISegmentedControl!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var hasMajoritySwitch: UISwitch!
    @IBOutlet weak var catRacesPickerView: UIPickerView!
    
    
    
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        nameTextField.resignFirstResponder()
        phoneTextField.resignFirstResponder()
    }
    @objc func keyboardAppear(_ notification: Notification){
        guard let frame = notification.userInfo? [UIViewController.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        let keyboardFrame = frame.cgRectValue
        if self.view.frame.origin.y == 0 {
            self.view.frame.origin.y -= keyboardFrame.height
        }
    }
    
    @objc func keyboardDisappear(_ notification: Notification){
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }

    @IBAction func validateForm(_ sender: Any) {
        self.createCatPet()
    }
    
    
    private func createCatPet(){
        let name = nameTextField.text
        let phone = phoneTextField.text
        let hasMajority = hasMajoritySwitch.isOn
        let genderSelectedIndex = genderSegmented.selectedSegmentIndex
        let genderChosen: Gender = genderSelectedIndex == 0 ? Gender.male : Gender.female
        
        let raceIndex = catRacesPickerView.selectedRow(inComponent: 0)
        let race = dogRaces[raceIndex]
        
        
        let cat = Pet(name: name, hasMajority: hasMajority, phone: phone, race: race, gender: genderChosen)
        
    }
}
extension CatFormViewController: UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return catRaces.count
    }
}
extension CatFormViewController: UIPickerViewDelegate{
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return catRaces[row]
        
    }
}

extension CatFormViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
