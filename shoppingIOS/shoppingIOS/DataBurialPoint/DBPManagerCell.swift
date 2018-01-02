//
//  DBPManagerCell.swift
//  shoppingIOS
//
//  Created by Darsky on 2018/1/2.
//  Copyright © 2018年 Holy. All rights reserved.
//

import UIKit

class DBPManagerCell: UITableViewCell
{
    @IBOutlet weak var _nameLabel: UILabel!
    @IBOutlet weak var _pageLabel: UILabel!
    @IBOutlet weak var _durationLabel: UILabel!
    
    @IBOutlet weak var _strLabel: UILabel!
    
    @IBOutlet weak var _endLabel: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        _nameLabel.adjustsFontSizeToFitWidth = true
        _pageLabel.adjustsFontSizeToFitWidth = true
        _durationLabel.adjustsFontSizeToFitWidth = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupDisplayDBPInfoWithDic(dic:NSDictionary) -> ()
    {
        _nameLabel.text = dic["name"] as? String
        _pageLabel.text = dic["page"] as? String
        _durationLabel.text = dic["duration"] as? String
        _strLabel.text = dic["startTime"] as? String
        _endLabel.text = dic["endTime"] as? String

    }
    
}
