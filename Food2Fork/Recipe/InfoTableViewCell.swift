//
//  InfoTableViewCell.swift
//  Food2Fork
//
//  Created by Michael Redoble on 19/11/2017.
//  Copyright © 2017 mjredoble. All rights reserved.
//

import UIKit

class InfoTableViewCell: UITableViewCell {
    
    var cellText: String? {
        didSet {
            configureView()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func configureView() {
        self.textLabel?.textColor = UIColor.blue
        self.textLabel?.text = cellText
        self.textLabel?.textAlignment = .center
    }
}
