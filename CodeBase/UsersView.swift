//
//  UsersViewController.swift
//  CodeBase
//
//  Created by Hafiz on 18/09/2017.
//  Copyright © 2017 github. All rights reserved.
//

import UIKit

protocol UserListInterface {
    func showLoading()
    func hideLoading()
    func showEmptyView()
    func reloadList(data: [User])
}

class UsersView: UIViewController {

    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    var tableData = [User]()
    let presenter = UserPresenter(service: UserService())
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // bind this view(controller) with presenter
        presenter.attachView(view: self)
        
        setupView()
        setupTable()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // fetch data
        presenter.fetchData()
    }
    
    func setupView() {
        self.title = "Github Users"
        view.backgroundColor = .background
    }
    
    func setupTable() {
        
        // setup tableview
        tableView.rowHeight = UserListViewCell.rowHeight
        
        tableView.backgroundColor = .clear
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.contentInset = UIEdgeInsets(top: 16, left: 0, bottom: 16, right: 0)
        
        // cell setup
        tableView.register(UINib(nibName: UserListViewCell.identifier, bundle: nil), forCellReuseIdentifier: UserListViewCell.identifier)
    }
}

extension UsersView: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let user = tableData[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: UserListViewCell.identifier) as! UserListViewCell
        cell.setupCell(user: user)
        return cell
    }
}

extension UsersView: UserListInterface {
    func showLoading() {
        tableView.isHidden = true
        spinner.startAnimating()
    }
    
    func hideLoading() {
        spinner.stopAnimating()
    }
    
    func showEmptyView() {
        tableView.isHidden = false
        
        // show some message here
    }
    
    func reloadList(data: [User]) {
        tableView.isHidden = false
        tableData = data
        tableView.reloadData()
    }
}
