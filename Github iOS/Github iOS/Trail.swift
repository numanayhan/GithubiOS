//
//  Trail.swift
//  Github iOS
//
//  Created by Numan Ayhan on 27.10.2021.
//

import UIKit
import TinyConstraints
import Firebase
 
    
class Trail: UIViewController  ,Coordinating{
    var coordinator: Coordinator?
    lazy var go:UIButton = {
        
        let button = UIButton(frame: CGRect.init(x: 100, y: 100, width: 240, height: 60))
        button.setTitle("Go", for: .normal)
        button.backgroundColor = UIColor.white
        button.setTitleColor(UIColor.black, for: .normal)
        button.addTarget(self , action: #selector(goLaunch), for: .touchUpInside)
        
        return button
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
  
        setLayout()
    }
    func setLayout(){
        view.backgroundColor = .darkGray
        view.addSubview(go)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if navigationController != nil{
            
        }
    }
    @objc func goLaunch(){
        coordinator?.eventOccured(with: .launch)
    }

}
