//
//  TopMenu.swift
//  Github iOS
//
//  Created by Numan Ayhan on 2.11.2021.
//

import UIKit

class TopMenu: UIViewController {
    let container = Container()
    var viewControllers : [UIViewController]  = [Search(),NameLists()]
    lazy var containerView:UIView = {
       let view = UIView() 
        
        return view
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
 
        setupContainer()
        setChildController(0,1)
        
    }
    func makeRoundedAndShadowed(view: UIView) {
        
        view.layer.cornerRadius  = 30
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.layer.shadowColor = UIColor.hex("#241C74").cgColor
        view.layer.shadowOffset = .zero
        view.layer.shadowOpacity = 1
        view.layer.shadowRadius = 10
        view.layer.shouldRasterize = true
        view.layer.shadowPath = UIBezierPath(roundedRect: container.view.bounds, byRoundingCorners:[.topLeft,.topRight],cornerRadii: .zero).cgPath
        
    }
    func setupContainer(){
        
        view.backgroundColor = UIColor.hex("#6D5EF7")
        container.view.backgroundColor = UIColor.hex("#FFFFFF")
        containerView = container.view
        makeRoundedAndShadowed(view: containerView)
        
        view.addSubview(containerView)
        containerView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 200, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: view.frame.width, height: view.frame.height)
        

    }
    func setChildController(_ childIndex:Int, _ removeIndex:Int?){
        
        if container.children.first == viewControllers[childIndex]  { return}
        let  childView = viewControllers[childIndex]
        childView.view.layer.cornerRadius  = 30
        childView.view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        container.add(childView)
        if removeIndex != nil{
            viewControllers[removeIndex!].remove()
        }
        
    }
}
