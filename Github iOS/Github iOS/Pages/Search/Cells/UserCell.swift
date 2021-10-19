//
//  UserCell.swift
//  Github iOS
//
//  Created by Numan Ayhan on 19.10.2021.
//

import UIKit
import TinyConstraints

class UserCell: UITableViewCell {
    var userName:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24)
        label.textColor = .black
        
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
    var avatar_url :String?
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setLayout()
        
    }
    
    func setLayout(){
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        let backgroundView = UIView()
        backgroundView.backgroundColor = .clear
        selectedBackgroundView = backgroundView
        
        
        contentView.addSubview(avatar)
        avatar.leftToSuperview().constant = 20
        avatar.height(80)
        avatar.width(80)
        
        contentView.addSubview(userName)
        userName.anchor(top: contentView.topAnchor, left: avatar.rightAnchor, bottom: nil , right: nil , paddingTop: 2, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: contentView.frame.width , height: contentView.frame.height/2)
        
       
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected {
            contentView.backgroundColor = UIColor.clear
        } else if isHighlighted{
            contentView.backgroundColor = UIColor.clear
        }else{
            contentView.backgroundColor = .clear
        }
    }
    required init?(coder: NSCoder) {
        fatalError()
    }
}
