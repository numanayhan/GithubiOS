//
//  Search.swift
//  Github iOS
//
//  Created by Numan Ayhan on 19.10.2021.
//

import UIKit
import SDWebImageSVGCoder
import Alamofire
import AlamofireImage
import NVActivityIndicatorView

class Search: UIViewController {
    //TableView objesinde aynı isimle id tanımlandı.
    fileprivate let identifierCell = "UserCell"
    // Arama işlemi için UISearchController özellikleri tanımlandı.
    private lazy var searchController: UISearchController = {
        let sc = UISearchController(searchResultsController: nil)
        sc.searchBar.placeholder = "Search User"
        sc.searchResultsUpdater = self
        sc.delegate = self
        sc.obscuresBackgroundDuringPresentation = false
        sc.searchBar.autocapitalizationType = .allCharacters
        sc.hidesNavigationBarDuringPresentation = true
        sc.dimsBackgroundDuringPresentation = false
        sc.searchBar.searchBarStyle = .minimal
        sc.definesPresentationContext = false
        //        sc.searchBar.enablesReturnKeyAutomatically  = true
        //        sc.extendedLayoutIncludesOpaqueBars = false
        sc.searchBar.keyboardType = .alphabet
        sc.searchBar.keyboardAppearance = .default
        sc.searchBar.returnKeyType = .done
        return sc
    }()
    //TableView tanımlandı
    lazy var tableView:UITableView = {
        let tv = UITableView()
        
        return tv
    }()
    // User Modeli tanımlandı.
    var users = [User]()
    // Arama için aynı User Modeli tanımlandı.
    var searchUser  = [User]()
    //locale storage kayıt edilmesi için string array değişken tanımlandı.
    var localeUsers = [String]()
    //  SearchBar boş olması alındı.
    var isSearchBarEmpty: Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    // Arama yapılması değişken ile tanımlandı.
    var isSearching:Bool{
        return searchController.isActive && !isSearchBarEmpty
    }
    //  Search : UIViewController class'ına özel MVVM tanımlandı.
    lazy var viewModel: SearchMVVM = {
        return SearchMVVM()
    }()
    var selectedIndex = 0
    var selectedIndexPath = IndexPath(item: 0, section: 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setLayout()
        setTableView()
        getUsers()
        
        view.layer.cornerRadius  = 30
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    // UI Objeleri biçimlendirildi.
    func setLayout(){
        
        view.backgroundColor = .white
        navigationItem.title = "Github Users"
        
    }
    
    func setTableView(){
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .white
        tableView.estimatedRowHeight = 100
        tableView.register(UserCell.self, forCellReuseIdentifier: identifierCell)
        tableView.separatorStyle  = .none
        tableView.separatorInset = .zero
        tableView.separatorEffect = .none
        view.addSubview(tableView)
        tableView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor , right: view.rightAnchor, paddingTop: 50, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: view.frame.width, height: view.frame.height)
        tableView.reloadData()
        
    }
    // Kullanıcılar listeye getirildi.
    //Singleton özellikleri kullanıldı.
    func getUsers(){
        if Network.isConnected(){
            viewModel.getUsers { users  in
                
                self.users = users
                self.tableView.reloadData()
            }
        }
         
    }
    // Aranan kullanıcı listeye getirildi.
    func searchUser(_ searchText:String){
        viewModel.searchUsers(searchText) { user  in
            self.searchUser = [user]
            self.tableView.reloadData()
        }
    }
    
}
extension Search: UITableViewDelegate, UITableViewDataSource{
    // Github user listesi liste sayısı olarak geri dönüş verildi.
    // Arama ile bu liste son aranan kişiye göre geri dönüş verildi.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearching{
            return searchUser.count
        }
        return users.count
        
        
    }
    //Her bir Cell yüksekliği 100 birim olarak değiştirilmiştir.
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    // Kullanıcı adı resmi her bir cell de eşleştirildi.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: identifierCell, for: indexPath) as? UserCell
        var userName:User
        if isSearching && searchController.searchBar.text!.count > 2{
            userName =  searchUser[indexPath.row]
        }else{
            userName =  users[indexPath.row]
            
        }
        
        
        cell!.userName.text =  userName.login
        
        cell!.avatar.showActivityIndicator()
        let imgUrl = userName.avatar_url!
        cell!.avatar_url = imgUrl
        if !imgUrl.isEmpty {
            let url = URL(string: imgUrl)
            let SVGCoder = SDImageSVGCoder.shared
            SDImageCodersManager.shared.addCoder(SVGCoder)
            cell?.avatar.sd_setImage(with: url)
            cell?.avatar.hideActivityIndicator()
        }
       
        
        let login = localeUsers.filter { $0.contains(cell!.userName.text!) }

        if !login.isEmpty{
            cell!.userName.textColor = .lightGray
        }
        
        return cell!
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath) as? UserCell
        cell!.userName.textColor = .lightGray
        localeUsers.append(cell!.userName.text!)
        UserDefaults.standard.set(localeUsers, forKey: "users")
        let myarray =  UserDefaults.standard.stringArray(forKey: "users") ?? [String]()
        if myarray.count > 0{
            var delegate: UserDetailDG?
            let detail  = UserDetail()
             
            detail.setUser(User.init(login: cell!.userName.text!, avatar_url: cell!.avatar_url, active: true ))
            self.navigationController?.pushViewController(detail, animated: true)
        }
        
    }
}

extension Search : UISearchResultsUpdating, UISearchControllerDelegate{
    //github users içinde listemele yapılır
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        if text.count > 2{
            searchUser(text.lowercased())
        }else {
            getUsers()
        }
    }
}
var rightBarItem = UIBarButtonItem()
extension Search{
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.setHidesBackButton(true, animated:true)
        setNavigationBar()
        DispatchQueue.main.async {
            UIView.performWithoutAnimation {
                self.searchController.isActive = true
            }
        }
    }
    
    func setNavigationBar(){
        if navigationController != nil {
            navigationController?.setNavigationBarHidden(false, animated: true)
            navigationController?.navigationBar.isHidden = false
            navigationItem.setHidesBackButton(true, animated:false)
            navigationController?.navigationBar.prefersLargeTitles = true
            searchController.searchBar.setValue("İptal", forKey: "cancelButtonText")
            self.navigationItem.searchController  = searchController
        }
    }
    
    @objc func cancelSearch(){
        self.view.endEditing(true)
        self.navigationItem.searchController?.isActive = true
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
        self.navigationItem.searchController?.isActive = true
    }
}

