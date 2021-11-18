//
//  EditViewController.swift
//  StoryboardContact
//
//  Created by Asadulla Juraev on 03/11/21.
//

import UIKit

class EditViewController: BaseViewController {
    
    @IBOutlet weak var bodyTextView: UITextField!
    @IBOutlet weak var bodyLabel: UILabel!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var titleLabel: UILabel!
    
    var ContactID: String = "1"
    var contact : Contact = Contact()
    var viewModel = EditViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.controller = self
        viewModel.apiCallContact(id: Int(ContactID)!, handler: { contact in
            if contact != nil {
                self.contact = contact
                self.initViews()
            }else{
                // error message
            }
        })
    }

    @IBAction func buttonPressed(_ sender: Any) {
        viewModel.apiEditContact(id: Int(ContactID)!, contact: Contact(name: titleTextField.text!, number: bodyTextView.text!), handler: { status in
            if status{
                self.dismiss(animated: false, completion: nil)
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil)
            }else{
                // error message
            }
        })
    }
    
    func initViews(){
        bodyLabel.text = "Name"
        titleLabel.text = "Number"
        DispatchQueue.main.async {
            self.bodyTextView.text = self.contact.number!
            self.titleTextField.text = self.contact.name!
        }
        
    }
    
    
}
