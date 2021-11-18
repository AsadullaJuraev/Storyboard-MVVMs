//
//  HomeViewModel.swift
//  StoryboardContact
//
//  Created by Asadulla Juraev on 18/11/21.
//

import Foundation
import Bond

class HomeViewModel{
    
    var controller: BaseViewController!
    
    var items = Observable<[Contact]>([])
    
    func apiContactList(){
        controller?.showProgress()
        AFHttp.get(url: AFHttp.API_CONTACT_LIST, params: AFHttp.paramsEmpty()) { response in
            self.controller?.hideProgress()
            switch response.result {
            case .success:
                let contacts = try! JSONDecoder().decode([Contact].self, from: response.data!)
                self.items.value = contacts
            case let .failure(error):
                print(error)
                self.items.value = [Contact]()
            }
        }
    }

    func apiContactDelete(contact: Contact, handler: @escaping (Bool) -> Void){
        controller?.showProgress()
        AFHttp.del(url: AFHttp.API_CONTACT_DELETE + contact.id!, params: AFHttp.paramsEmpty(), handler: { response in
            self.controller?.hideProgress()
            switch response.result {
            case .success:
                print(response.result)
                handler(true)
            case let .failure(error):
                print(error)
                handler(false)
            }
        })
    }
    
    
}
