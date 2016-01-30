//
//  MenuTableViewCell.swift
//  CMP10C
//
//  Created by Adrian Mateoaea on 29.01.2016.
//  Copyright © 2016 CMP10C. All rights reserved.
//

import UIKit
import SnapKit

class MenuTableViewCell: UITableViewCell {

    var separatorView: UIImageView!
    
    var selectionView: UIImageView!
    
    var iconView: UIImageView!
    
    var titleLabel: UILabel!
    
    var circleView: UIView!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = UIColor.clearColor()
        
        self.separatorView = UIImageView()
        self.separatorView.image = UIImage(named: "separator")
        self.addSubview(self.separatorView)
        self.separatorView.snp_makeConstraints { (make) -> Void in
            make.leading.equalTo(self)
            make.trailing.equalTo(self)
            make.bottom.equalTo(self)
            make.height.equalTo(2)
        }
        
        self.selectionView = UIImageView()
        self.selectionView.hidden = true
        self.selectionView.image = UIImage(named: "selection")
        self.addSubview(self.selectionView)
        self.selectionView.snp_makeConstraints { (make) -> Void in
            make.edges.equalTo(self)
        }

        self.iconView = UIImageView()
        self.iconView.tintColor = UIColor.whiteColor()
        self.addSubview(self.iconView)
        self.iconView.snp_makeConstraints { (make) -> Void in
            make.leading.equalTo(self).offset(40)
            make.centerY.equalTo(self)
        }
        
        self.titleLabel = UILabel()
        self.titleLabel.textColor = UIColor.whiteColor()
        self.titleLabel.font = Font.menuLabelFont
        self.titleLabel.setContentHuggingPriority(249, forAxis: UILayoutConstraintAxis.Horizontal)
        self.addSubview(self.titleLabel)
        self.titleLabel.snp_makeConstraints { (make) -> Void in
            make.leading.equalTo(self.iconView.snp_trailing).offset(20)
            make.centerY.equalTo(self)
        }
        
        self.circleView = UIView()
        self.circleView.transform = CGAffineTransformMakeTranslation(-5, 0)
        self.circleView.backgroundColor = UIColor.whiteColor()
        self.circleView.layer.cornerRadius = 5
        self.addSubview(self.circleView)
        self.circleView.snp_makeConstraints { (make) -> Void in
            make.leading.equalTo(self).offset(-5)
            make.centerY.equalTo(self)
            make.size.equalTo(10)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setSelected(selected: Bool, animated: Bool) {
        self.selectionView.hidden = !selected
        self.separatorView.hidden = selected
        
        UIView.animateWithDuration(0.4) { () -> Void in
            if selected {
                self.circleView.transform = CGAffineTransformIdentity
            } else {
                self.circleView.transform = CGAffineTransformMakeTranslation(-5, 0)
            }
        }
    }
    
    override func setHighlighted(highlighted: Bool, animated: Bool) {
        //
    }

}
