//
//  CreateViewController.swift
//  StoryboardContact
//
//  Created by Asadulla Juraev on 03/11/21.
//

import UIKit

class CreateViewController: BaseViewController{
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var bodyLabel: UILabel!
    @IBOutlet weak var bodyTextView: UITextField!
    
    var viewModel = CreateViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViews()
    }

    func initViews(){
       
        viewModel.controller = self
        titleLabel.text = "Name"
        bodyLabel.text = "Number"

        let add = UIImage(named: "ic_send")
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: add, style: .plain, target: self, action: #selector(rightTapped))
    }

    @objc func rightTapped(){
        if titleField.text != "" && bodyTextView.text != "" {
            viewModel.apiCreateContact(contact: Contact(name: titleField.text!, number: bodyTextView.text!), handler: { status in
                if status {
                    self.navigationController?.popViewController(animated: true)
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil)
                }else{
                    // something went wrong! 😐
                }
            })
            
        }
    }
    
}
