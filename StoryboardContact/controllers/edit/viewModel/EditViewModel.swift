//
//  EditViewModel.swift
//  StoryboardContact
//
//  Created by Asadulla Juraev on 18/11/21.
//

import Foundation
import Foundation
import Bond

class EditViewModel{
    
    var controller: BaseViewController!
    
    func apiCallContact(id: Int, handler: @escaping (Contact)->Void){
        controller?.showProgress()
        AFHttp.get(url: AFHttp.API_CONTACT_SINGLE + String(id), params: AFHttp.paramsContactWith(id: id), handler: { response in
            self.controller?.hideProgress()
            switch response.result {
            case .success:
                let decode = try! JSONDecoder().decode(Contact.self, from: response.data!)
                handler(decode)
            case let .failure(error):
                print(error)
                handler(Contact())
            }
        })
    }
   
    func apiEditContact(id: Int, contact: Contact, handler: @escaping (Bool)->Void) {
        controller?.showProgress()
        AFHttp.put(url: AFHttp.API_CONTACT_UPDATE + String(id), params: AFHttp.paramsContactUpdate(contact: contact)) { response in
            self.controller?.hideProgress()
            switch response.result {
            case .success:
                print("SUCCESS")
                handler(true)
            case let .failure(error):
                print(error)
                handler(true)
            }
        }
    }
}
