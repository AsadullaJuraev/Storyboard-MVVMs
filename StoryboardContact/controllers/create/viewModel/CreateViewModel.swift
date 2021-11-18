//
//  CreateViewModel.swift
//  StoryboardContact
//
//  Created by Asadulla Juraev on 18/11/21.
//

import Foundation

class CreateViewModel{
    
    var controller: BaseViewController!
    
    func apiCreateContact(contact: Contact, handler: @escaping (Bool) -> Void){
        self.controller?.showProgress()
        AFHttp.post(url: AFHttp.API_CONTACT_CREATE, params: AFHttp.paramsContactCreate(contact: contact)) { response in
            self.controller?.hideProgress()
            switch response.result {
            case .success:
                print("SUCCESS")
                handler(true)
            case let .failure(error):
                print(error)
                handler(false)
            }
        }
    }
    
    
}
