//
//  Launch.swift
//  Github iOS
//
//  Created by Numan Ayhan on 19.10.2021.
//

import UIKit
import TinyConstraints
import Firebase

class Launch: UIViewController ,Coordinating{
    var coordinator: Coordinator?
    
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
        
//        appRoot?.nameList()
        let actualStartDate = "2021-02-08T06:30:00Z"
        
        var startDate =  actualStartDate
//        let dateStart = startDate.getFormattedDate(format: "dd.MM.yyyy-HH:mm")
//        print("dateStart",dateStart)
        startDate = startDate.convertDateString(date: startDate, format: "dd.MM.yyyy-HH:mm")
        print("startDate",startDate)
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
//        startTimer()
    }
    
    func startTimer() {
        stopTimer()
        timer = Timer.scheduledTimer(withTimeInterval: 1.66, repeats: false) {  _ in
             
            self.navigationController?.pushViewController(TopMenu(), animated: true)
        }
    }
    func stopTimer() {
        timer?.invalidate()
    }
    deinit {
        stopTimer()
    }
    override func viewDidAppear(_ animated: Bool) {
      // checkForUpdate()
    }
    private func checkForUpdate() {
        AppDistribution.appDistribution().checkForUpdate(completion: { [self] release, error in
          var uiAlert: UIAlertController

          if error != nil {
            uiAlert = UIAlertController(title: "Error", message: "Error Checking for update! \(error?.localizedDescription ?? "")", preferredStyle: .alert)
          } else if release == nil {
            uiAlert = UIAlertController(title: "Check for Update", message: "No releases found!!", preferredStyle: .alert)
            uiAlert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default))
          } else {
            guard let release = release else { return }

            let title = "New Version Available"
            let message = "Version \(release.displayVersion)(\(release.buildVersion)) is available."
            uiAlert = UIAlertController(title: title, message: message, preferredStyle: .alert)

            uiAlert.addAction(UIAlertAction(title: "Update", style: UIAlertAction.Style.default) {
              _ in
              UIApplication.shared.open(release.downloadURL)
            })
            uiAlert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel) {
              _ in
            })
          }
          self.present(uiAlert, animated: true, completion: nil)
        })
      }
}
