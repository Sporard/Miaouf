//
//  SuccessViewController.swift
//  Miaouf
//
//  Created by Pierre Sabard on 13/06/2023.
//

import UIKit

class SuccessViewController: UIViewController {

    // Controller model attributes
    var pet: Pet?
    
    @IBOutlet weak var successText: UILabel!
    
    // Override functions
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setSuccessTextLabel()

        // Do any additional setup after loading the view.
    }
    
    
    /*
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
     */
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//    }
    
    @IBAction func dimiss(_ sender: Any) {
        dismiss(animated: true)
    }
    
    private func setSuccessTextLabel() {
        if let name = pet?.name {
            self.successText.text = "Bienvenue à \(name)" 
        }
    }
    

}

