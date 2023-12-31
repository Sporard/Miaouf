//
//  FormViewController.swift
//  Miaouf
//
//  Created by Pierre Sabard on 13/06/2023.
//

import UIKit

class FormViewController: UIViewController {
    
    // MARK: Outlet
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var sexeField: UISegmentedControl!
    @IBOutlet weak var majoritySwitch: UISwitch!
    @IBOutlet weak var racePickerView: UIPickerView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardAppear(_:)), name: UIViewController.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDisappear(_:)), name: UIViewController.keyboardWillHideNotification, object: nil)
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
    
}

// MARK: pickerView
extension FormViewController: UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return dogRaces.count
    }
}
extension FormViewController: UIPickerViewDelegate{
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return dogRaces[row]
        
    }
}

// MARK: keyboard
extension FormViewController: UITextFieldDelegate{
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        nameTextField.resignFirstResponder()
        phoneTextField.resignFirstResponder()
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

// MARK: - Validation
extension FormViewController {
    @IBAction func validateForm() {
        let pet = self.createPetObject()
        self.validatePet(pet)
    }
    
    
    private func validatePet(_ pet: Pet) {
        switch (pet.status){
        case .accepted:
            performSegue(withIdentifier: "segueToSuccess", sender: pet)
        case .rejected(let reason):
            self.presentAlert(reason)

        }
    }
    
    private func presentAlert(_ reason: String) {
        let alertVC = UIAlertController(title: "Erreur", message: reason, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertVC.addAction(action)
        present(alertVC, animated: true, completion: nil)
    }
    
    private func createPetObject() -> Pet{
        let name = nameTextField.text
        let phone = phoneTextField.text
        let hasMajority = majoritySwitch.isOn
        let genderSelectedIndex = sexeField.selectedSegmentIndex
        let genderChosen: Pet.Gender = genderSelectedIndex == 0 ? Pet.Gender.male : Pet.Gender.female
        
        let raceIndex = racePickerView.selectedRow(inComponent: 0)
        let race = dogRaces[raceIndex]
        
        return Pet(name: name, hasMajority: hasMajority, phone: phone, race: race, gender: genderChosen)
        
    }
}
// MARK: - Navigation
extension FormViewController {
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToSuccess"{
            let successVC = segue.destination as? SuccessViewController
            let pet = sender as? Pet
            successVC?.pet = pet
        }
    }
}
