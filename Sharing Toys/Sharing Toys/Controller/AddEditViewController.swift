//
//  AddEditViewController.swift
//  Sharing Toys
//
//  Created by Willian S. on 04/01/22.

import Firebase
import UIKit

enum OperationType: String {
    case add = "Incluir"
    case edit = "Atualizar"
}

class AddEditViewController: UIViewController {
    var toy: Toy!
    var operation: OperationType {
        return toy == nil ? .add : .edit
    }
    let repository = Repository.shared

    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var stateSegmentedControl: UISegmentedControl!
    @IBOutlet var giverTextField: UITextField!
    @IBOutlet var addressTextField: UITextField!
    @IBOutlet var phoneTextField: UITextField!
    @IBOutlet var addEditButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        clearAll()
        prepareScreen()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }

    private func clearAll() {
        nameTextField.text?.clear()
        stateSegmentedControl.selectedSegmentIndex = -1
        giverTextField.text?.clear()
        addressTextField.text?.clear()
        phoneTextField.text?.clear()
        addEditButton.setTitle(operation.rawValue, for: .normal)
        navigationItem.title = operation.rawValue
    }

    private func prepareScreen() {
        guard let toy = toy else { return }
        nameTextField.text = toy.name
        stateSegmentedControl.selectedSegmentIndex = toy.state
        giverTextField.text = toy.giver
        addressTextField.text = toy.address
        phoneTextField.text = toy.phone
        addEditButton.setTitle(operation.rawValue, for: .normal)
    }

    @IBAction func confirmOperation(_ sender: UIButton) {
        guard let name = nameTextField.text,
              let giver = giverTextField.text,
              let address = addressTextField.text,
              let phone = phoneTextField.text
        else {
            return
        }

        let state = stateSegmentedControl.selectedSegmentIndex

        let data: [String: Any] = [
            "name": name,
            "state": state,
            "giver": giver,
            "address": address,
            "phone": phone,
        ]
        
        repository.save(toy, data) { response in
            response == .sucess ? self.close() : print("Erro")
        }
        
    }
    
    func close() {
        navigationController?.popViewController(animated: true)
    }

    /*
     // MARK: - Navigation

     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         // Get the new view controller using segue.destination.
         // Pass the selected object to the new view controller.
     }
     */
}
