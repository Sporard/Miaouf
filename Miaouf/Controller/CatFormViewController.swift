//
//  CatFormViewController.swift
//  Miaouf
//
//  Created by Pierre Sabard on 22/06/2023.
//

import UIKit

class CatFormViewController: UIViewController {
    
    // MARK: Outlet
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var genderSegmented: UISegmentedControl!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var hasMajoritySwitch: UISwitch!
    @IBOutlet weak var catRacesPickerView: UIPickerView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardAppear(_:)), name: UIViewController.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDisappear(_:)), name: UIViewController.keyboardWillHideNotification, object: nil)
        // Do any additional setup after loading the view.
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

// MARK: Keyboard
extension CatFormViewController: UITextFieldDelegate{
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        nameTextField.resignFirstResponder()
        phoneTextField.resignFirstResponder()
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

// MARK: Validation
extension CatFormViewController {
    @IBAction func validateForm(_ sender: Any) {
        let pet = self.createCatPet()
        self.validatePet(pet)
    }
    
    private func validatePet(_ pet: Pet){
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
    
    private func createCatPet() -> Pet {
        let name = nameTextField.text
        let phone = phoneTextField.text
        let hasMajority = hasMajoritySwitch.isOn
        let genderSelectedIndex = genderSegmented.selectedSegmentIndex
        let genderChosen: Pet.Gender = genderSelectedIndex == 0 ? Pet.Gender.male : Pet.Gender.female
        
        let raceIndex = catRacesPickerView.selectedRow(inComponent: 0)
        let race = dogRaces[raceIndex]
        
        
        return Pet(name: name, hasMajority: hasMajority, phone: phone, race: race, gender: genderChosen)
        
    }
}
