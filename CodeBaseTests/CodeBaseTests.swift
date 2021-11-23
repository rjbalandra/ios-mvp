//
//  CodeBaseTests.swift
//  CodeBaseTests
//
//  Created by Hafiz on 18/09/2017.
//  Copyright © 2017 github. All rights reserved.
//

import XCTest
@testable import CodeBase

class CodeBaseTests: XCTestCase {
    
//    UserService <- UserPresenter <-  UsersView: UserListInterface
//    Mock        <- legit Presenter <- Mock
//
    var service: Service?
    var presenter: UserPresenter?
    var interface: MockUserListInterface?
    
    override func setUp() {
        super.setUp()
        service = SuccessMockUserService()
        presenter = UserPresenter(service: service as! Service)
        interface = MockUserListInterface()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        service = nil
        presenter = nil
        interface = nil
    }
    
    func testfetchData_whenSourceHasUsers_thenReloadList() {
        //When
        presenter?.attachView(view: interface as! UserListInterface)
        presenter?.fetchData()
        
        //Then
        XCTAssert(interface!.isSuccess == true)
    }
    
    func testfetchData_whenSourceHasUsers_thenShowEmptyView() {
        //When
        service = FailureMockUserService()
        presenter = UserPresenter.init(service: service as! Service)
        presenter?.attachView(view: interface as! UserListInterface)
        presenter?.fetchData()
        
        //Then
        XCTAssert(interface!.isSuccess == false)
    }
    
    
}

class MockUserListInterface: UserListInterface {
    var isSuccess: Bool = true
    
    func showLoading() {
        
    }
    func hideLoading() {
        
    }
    func showEmptyView() {
        isSuccess = false
    }
    func reloadList(data: [User]) {
        isSuccess = true
    }
}

class SuccessMockUserService: Service {
    func getUsers(callback:@escaping (Result<[User]?, Error>) -> Void) {
        let user = User(id: 1)
        callback(.success([user]))
    }
}

class FailureMockUserService: Service {
    func getUsers(callback:@escaping (Result<[User]?, Error>) -> Void) {
        callback(.failure(LocalError()))
    }
}

