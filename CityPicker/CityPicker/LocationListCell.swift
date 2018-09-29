//
//  LocationListCell.swift
//  CityPicker
//
//  Created by 龚杰洪 on 2018/9/29.
//  Copyright © 2018年 龚杰洪. All rights reserved.
//

import UIKit

internal class LocationListCell: UITableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupDefault()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupDefault()
    }
    
    func setupDefault() {
        self.textLabel?.font = UIFont.systemFont(ofSize: 15.0)
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
