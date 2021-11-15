//
//  Launch.swift
//  Github iOS
//
//  Created by Numan Ayhan on 19.10.2021.
//

import UIKit
import TinyConstraints
import Firebase
func countLines(of label: UILabel, maxHeight: CGFloat) -> Int {
    guard let labelText = label.text else {
               return 0
           }
           
           let rect = CGSize(width: label.bounds.width, height: maxHeight)
           let labelSize = labelText.boundingRect(with: rect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: label.font!], context: nil)
           
           let lines = Int(ceil(CGFloat(labelSize.height) / label.font.lineHeight))
           return labelText.contains("\n") && lines == 1 ? lines + 1 : lines
   }
class Launch: UIViewController ,Coordinating{
    var coordinator: Coordinator?
    
    lazy var logo : TitleLabel = {
        let label = TitleLabel()
        
        label.text = "To fix this issue, we need to set correct number of lines required for that text to fit within required height."
        label.numberOfLines = 0
//        label.font = UIFont.boldSystemFont(ofSize: 34)
//        label.textAlignment = NSTextAlignment.center
        label.textColor = .white
        label.numberOfLines = countLines(of: label, maxHeight: 150)
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
