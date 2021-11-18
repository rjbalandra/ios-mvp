//
//  UserPresenter.swift
//  CodeBase
//
//  Created by Hafiz on 18/09/2017.
//  Copyright © 2017 github. All rights reserved.
//

import Foundation

class UserPresenter {
    
    var service: Service = UserService()
    
    var view: UserListInterface!
        
    func attachView(view: UserListInterface) {
        self.view = view
    }
    
    func fetchData() {
        view.showLoading()
        
        service.getUsers() { (success, data, errorMessage) in
            
            self.view.hideLoading()
            
            if let users = data, !users.isEmpty {
                self.view.reloadList(data: users)
            }
            else {
                self.view.showEmptyView()
            }
        }
    }
}
