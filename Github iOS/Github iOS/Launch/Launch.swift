//
//  Launch.swift
//  Github iOS
//
//  Created by Numan Ayhan on 19.10.2021.
//

import UIKit
import TinyConstraints

class Launch: UIViewController {
    lazy var logo : TitleLabel = {
        let label = TitleLabel()
        label.text = "Github"
        label.font = UIFont.boldSystemFont(ofSize: 34)
        label.textAlignment = NSTextAlignment.center
        label.textColor = .white
        return label
    }()
    weak var timer: Timer?
    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
    }
    func setLayout(){
        view.backgroundColor = .black
        view.addSubview(logo)
        logo.centerInSuperview()
        logo.width(view.frame.width)
        logo.height(90)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        startTimer()
    }
    func startTimer() {
        stopTimer()
        timer = Timer.scheduledTimer(withTimeInterval: 1.66, repeats: false) {  _ in
            self.navigationController?.pushViewController(Search(), animated: true)
        }
    }
    func stopTimer() {
        timer?.invalidate()
    }
    deinit {
        stopTimer()
    }
}
