//
//  Search.swift
//  Github iOS
//
//  Created by Numan Ayhan on 19.10.2021.
//

import UIKit

class Search: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
 
        setLayout()
    }
    // UI Objeleri biçimlendirildi.
    func setLayout(){
        
        view.backgroundColor = .white
        navigationItem.title = "Github Users"
        
    }
}
extension Search{
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.setHidesBackButton(true, animated:true)
        setNavigationBar()
         
    }
    
    func setNavigationBar(){
        if navigationController != nil {
            navigationController?.setNavigationBarHidden(false, animated: true)
            navigationController?.navigationBar.isHidden = false
            navigationItem.setHidesBackButton(true, animated:false)
            navigationController?.navigationBar.prefersLargeTitles = true
             
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

