//
//  DetailsViewController.swift
//  MiraiMVVM
//
//  Created by ＵＳＥＲ on 2019/11/28.
//  Copyright © 2019 hsin_project. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController, UITextViewDelegate {

    let viewModel = DetailsVCViewModel()
    var username: String = ""

    @IBOutlet weak var avatarImg: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var siteAdminLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var bioLabel: UILabel!
    @IBOutlet weak var siteAdminView: UIView!
    @IBOutlet weak var blogTextView: UITextView!
    @IBOutlet weak var activityView: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        blogTextView.delegate = self
        self.setUI()
        bindViewModel()
        viewModel.fetchSingleUser(username: self.username)
        self.activityView.startAnimating()
    }
    
    // MARK: - UI Setting
     func setUI() {
        self.avatarImg.layer.cornerRadius = self.avatarImg.frame.size.width / 2
        self.siteAdminLabel.layer.cornerRadius = 15
        self.siteAdminLabel.clipsToBounds = true
        
        self.loginLabel.text = ""
        self.nameLabel.text = ""
        self.bioLabel.text = ""
        self.blogTextView.text = ""
        self.locationLabel.text = ""
        self.siteAdminView.isHidden = true
    }
    
    // MARK: - Bind ViewModel
    func bindViewModel() {
        self.viewModel.onRequestEnd = { [weak self] in
            DispatchQueue.main.async {
                self?.setData(model: (self?.viewModel.detailsViewModel)!)
                self?.activityView.stopAnimating()
            }
        }
    }
   
    func setData(model:DetailsViewModel) {
        self.loginLabel.text = model.login
        if model.siteAdmin {
            self.siteAdminLabel.text = "Staff"
            self.siteAdminView.isHidden = false
        } else {
            self.siteAdminView.isHidden = true
        }
        
        self.nameLabel.text = model.name
        self.locationLabel.text = model.location
        self.bioLabel.text = model.bio
        let attributedString = NSMutableAttributedString(string: model.blog)
        let myAttribute = [ NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15) ]
        attributedString.addAttribute(.link, value: model.blog, range: NSMakeRange(0, model.blog.count))
        attributedString.addAttributes(myAttribute, range: NSMakeRange(0, model.blog.count))
        
        blogTextView.attributedText = attributedString
       
        model.onImageDownloaded = {[weak self] image in
            DispatchQueue.main.async {
                self?.avatarImg.image = image
            }
        }
        model.getImage()
    }
    
    // MARK: - UITextViewDelegate
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        
        UIApplication.shared.open(URL)
        return false
    }
    
    // MARK: - Dismiss VC
    @IBAction func dismissAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
