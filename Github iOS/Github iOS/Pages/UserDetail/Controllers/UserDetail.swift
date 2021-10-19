//
//  UserDetail.swift
//  Github iOS
//
//  Created by Numan Ayhan on 19.10.2021.
//

import UIKit
import SDWebImageSVGCoder
import Alamofire
import AlamofireImage
import NVActivityIndicatorView

class UserDetail: UIViewController ,UserDetailDG{

    var userName:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24)
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    lazy var avatar:UIImageView = {
       let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.backgroundColor = .white
        iv.layer.cornerRadius = 4
        iv.layer.borderWidth = 0.5
        iv.layer.borderColor = UIColor.lightGray.cgColor
        return iv
    }()
    //TableView tanımlandı
    lazy var tableView:UITableView = {
        let tv = UITableView()
        
        return tv
    }()
    // User Modeli tanımlandı.
    var users = [User]()
    //  Search : UIViewController class'ına özel MVVM tanımlandı.
    lazy var viewModel: UserDetailMVVM = {
        return UserDetailMVVM()
    }()
    var delegate: UserDetailDG?
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        setLayout()
        
    }
    // UI Objeleri biçimlendirildi.
    func setLayout(){
        
        view.backgroundColor = .white
     
        view.addSubview(avatar)
        avatar.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: nil , right: nil , paddingTop: 20, paddingLeft: 20, paddingBottom: 0, paddingRight: 0, width: 200, height: 200)
        
        view.addSubview(userName)
        userName.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: avatar.rightAnchor, bottom: nil , right: view.rightAnchor, paddingTop: 20, paddingLeft: 20, paddingBottom: 0, paddingRight: 0, width: view.frame.width, height: userName.frame.height)
        
        
    }
    func setUser(_ sender: User) {
        self.getUser(sender.login!)
    }
    func getUser(_ searchText:String){
        if Network.isConnected(){
        self.viewModel.searchUsers(searchText) { user  in
            self.userName.text = user.login
            
            let url = URL(string: user.avatar_url!)
            let SVGCoder = SDImageSVGCoder.shared
            SDImageCodersManager.shared.addCoder(SVGCoder)
            self.avatar.sd_setImage(with: url)
            self.avatar.hideActivityIndicator()
        }
        }
        
    }
}
extension UserDetail{
    override func viewWillAppear(_ animated: Bool) {
        
        setNavigationBar()
        
    }
    func setNavigationBar(){
        if navigationController != nil {
            navigationController?.setNavigationBarHidden(false, animated: true)
            navigationController?.navigationBar.isHidden = false
            navigationItem.setHidesBackButton(false, animated:false)
            navigationController?.navigationBar.prefersLargeTitles = false
            navigationItem.title = "User Detail"
        }
    }
    
}
