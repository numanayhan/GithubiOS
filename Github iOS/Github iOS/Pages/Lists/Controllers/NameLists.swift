//
//  NameLists.swift
//  Github iOS
//
//  Created by Numan Ayhan on 1.11.2021.
//

import UIKit
import TinyConstraints



class NameLists: UIViewController {
    
    fileprivate let identifierCell = "NamesCell"
    var names  = ["Ali Koç","Ayşe Demir","Ali Koç","Ayşe Demir Neresmlsdsdö södösdmsöd mösdkkmskksmdks","Ali Koç","Ayşe Demir"]
    //TableView tanımlandı
    lazy var tableView:UITableView = {
        let tv = UITableView()
        return tv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setLayout()
        
    }
    func setLayout(){
        setTableView()
    }
    func setTableView(){
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .white
        tableView.estimatedRowHeight = 40
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: identifierCell)
        tableView.separatorStyle  = .none
        tableView.separatorInset = .zero
        tableView.separatorEffect = .none
        view.addSubview(tableView)
        tableView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor , right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: view.frame.width, height: view.frame.height)
        tableView.reloadData()
        
        
    }
}
extension NameLists: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return names.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // Swift 4.2 onwards
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
        let cell = tableView.dequeueReusableCell(withIdentifier: identifierCell, for: indexPath)
        cell.textLabel?.text = names[indexPath.row]
        cell.textLabel?.textAlignment = .left
        cell.textLabel?.numberOfLines = 0
        
        
        return cell
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}
 
extension NameLists{
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.setHidesBackButton(true, animated:true)
        setNavigationBar()
    }
    func setNavigationBar(){
        if navigationController != nil {
            navigationController?.setNavigationBarHidden(false, animated: true)
            navigationController?.navigationBar.isHidden = false
            navigationItem.setHidesBackButton(true, animated:false)
            navigationController?.navigationBar.prefersLargeTitles = false
            
        }
    }
}
