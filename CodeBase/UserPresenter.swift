//
//  UserPresenter.swift
//  CodeBase
//
//  Created by Hafiz on 18/09/2017.
//  Copyright © 2017 github. All rights reserved.
//

import Foundation

class UserPresenter {
    
    var service: Service
    
    var view: UserListInterface!
        
    init (service: Service) {
        self.service = service
    }
    
    func attachView(view: UserListInterface) {
        self.view = view
    }
    
    func fetchData() {
        view.showLoading()
        
        
        service.getUsers() { (result) in
            
            self.view.hideLoading()
            
            
            switch result {
            case .success(let users):
                self.view.reloadList(data: users ?? [])
            case .failure(let error):
                self.view.showEmptyView()
            }
            
//            if let users = data, !users.isEmpty {
//                self.view.reloadList(data: users)
//            }
//            else {
//                self.view.showEmptyView()
//            }
        }
    }
}
