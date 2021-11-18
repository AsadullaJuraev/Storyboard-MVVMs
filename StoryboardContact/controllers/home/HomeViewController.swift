//
//  HomeViewController.swift
//  StoryboardContact
//
//  Created by Asadulla Juraev on 03/11/21.
//

import UIKit
import Bond

class HomeViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(doThisWhenNotify(notification:)), name: NSNotification.Name(rawValue: "load"), object: nil)
        initView()
        
    }
    
    func initView(){
        initNavigation()
        tableView.delegate = self
        tableView.dataSource = self
        bindViewModel()
        
        viewModel.apiContactList()
    }
    
    func bindViewModel(){
        viewModel.controller = self
        viewModel.items.bind(to: self) { strongSelf, _ in
            strongSelf.tableView.reloadData()
        }
    }
    
    func initNavigation(){
        let refresh = UIImage(named: "ic_refresh")
        let add = UIImage(named: "ic_add")
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: refresh, style: .plain, target: self, action: #selector(leftTapped))
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: add, style: .plain, target: self, action: #selector(rightTapped))
        title = "Contact list"

        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .gray
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]

        // Customizing our navigation bar
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    func callCreateViewController(){
        let vc = CreateViewController(nibName: "CreateViewController", bundle: nil)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func callEditViewController(id: String){
        let vc = EditViewController(nibName: "EditViewController", bundle: nil)
        vc.ContactID = id
        let navigationController = UINavigationController(rootViewController: vc)
        
        self.present(navigationController, animated: true, completion: nil)
    }

    @objc func leftTapped(){
        viewModel.apiContactList()
    }
    
    @objc func rightTapped(){
        callCreateViewController()
    }

    @objc func doThisWhenNotify(notification : NSNotification) {
        //update tableview

        viewModel.apiContactList()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.items.value.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = viewModel.items.value[indexPath.row]
        
        let cell = Bundle.main.loadNibNamed("ContactTableViewCell", owner: self, options: nil)?.first as! ContactTableViewCell
        cell.titleLabel.text = item.name
        cell.numberLabel.text = item.number
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        return UISwipeActionsConfiguration(actions: [
            makeCompleteContextualAction(forRowAt: indexPath, contact: viewModel.items.value[indexPath.row])
        ])
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        return UISwipeActionsConfiguration(actions: [
            makeDeleteContextualAction(forRowAt: indexPath, contact: viewModel.items.value[indexPath.row])
        ])
    }
    
    //MARK: - Contextual Actions
    
    private func makeDeleteContextualAction(forRowAt: IndexPath, contact: Contact) -> UIContextualAction{
        return UIContextualAction(style: .destructive, title: "Delete") { (action, swipeButtonView, completion) in
            completion(true)
            self.viewModel.apiContactDelete(contact: contact, handler: { result in
                if result {
                    self.viewModel.apiContactList()
                }
            })
        }
    }
    
    private func makeCompleteContextualAction(forRowAt: IndexPath, contact: Contact) -> UIContextualAction{
        return UIContextualAction(style: .normal, title: "Edit") { (action, swipeButtonView, completion) in
            
            completion(true)
            self.callEditViewController(id: contact.id!)
            
        }
    }
    
}
