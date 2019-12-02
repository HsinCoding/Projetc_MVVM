//
//  ViewController.swift
//  MiraiMVVM
//
//  Created by ＵＳＥＲ on 2019/11/27.
//  Copyright © 2019 hsin_project. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,APIManagerDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var avtivityView: UIActivityIndicatorView!
    
    let viewModel = VCViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableViewInheritance()
        self.bindViewModel()
        self.registerCustomCell()
        viewModel.fetchAllUser(since: "0")
        self.avtivityView.startAnimating()
    }
    
    // MARK: - TableView Delegate and datasource inheritance
    func tableViewInheritance() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    
    // MARK: - RegisterCustomCell
    
    func registerCustomCell() {
           tableView.register(UINib(nibName: "VCListCell", bundle: nil), forCellReuseIdentifier: "Cell")
    }
    
    // MARK: - Bind ViewModel
    func bindViewModel() {
         viewModel.onRequestEnd = { [weak self] in
             DispatchQueue.main.async {
                self?.tableView.reloadData()
                self?.avtivityView.stopAnimating()
             }
         }
     }
    

    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.listCellViewModels.count
       
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! VCListCell
        cell.avatarImage.layer.cornerRadius = cell.avatarImage.frame.size.width / 2
        cell.avatarImage.clipsToBounds = true
        cell.siteAdminLabel.layer.cornerRadius = 15
        cell.siteAdminLabel.clipsToBounds = true

        let listCellViewModel = viewModel.listCellViewModels[indexPath.row]
        cell.setup(viewModel: listCellViewModel)
        return cell
    }
    
    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        Router.shared.showDetailsVC(vc: self, viewModel: self.viewModel, indexPathRow: indexPath.row)
    }
    

}

