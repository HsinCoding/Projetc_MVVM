//
//  ViewController.swift
//  MiraiMVVM
//
//  Created by ＵＳＥＲ on 2019/11/27.
//  Copyright © 2019 hsin_project. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {


    @IBOutlet weak var tableView: UITableView!
    
    let viewModel = VCViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        bindViewModel()
        registerCustomCell()
        viewModel.fetchAllUser(since: "0")
        
        
    }
    
    // MARK: - RegisterCustomCell
    
    func registerCustomCell() {
           tableView.register(UINib(nibName: "VCListCell", bundle: nil), forCellReuseIdentifier: "Cell")
    }
    
    // MARK: - Bind ViewModel
    
    func bindViewModel() {
         viewModel.onRequestEnd = { [weak self] in
             DispatchQueue.main.async {
                print(self!.viewModel.listCellViewModels.count)
                self?.tableView.reloadData()
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
    
    
    
    

}

