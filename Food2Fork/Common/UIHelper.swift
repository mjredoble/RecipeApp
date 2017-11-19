//
//  UIHelper.swift
//  Food2Fork
//
//  Created by Michael Redoble on 19/11/2017.
//  Copyright © 2017 mjredoble. All rights reserved.
//

import UIKit

class UIHelper {

    class func emptyView(frame: CGRect, withText text: String) -> UIView {
        let emptyLabel = UILabel(frame: CGRect( x: 20, y: (frame.size.height / 2), width: frame.size.width - 40, height: 100))
        emptyLabel.backgroundColor = UIColor.clear
        emptyLabel.textAlignment = .center
        emptyLabel.textColor = UIColor.darkGray
        emptyLabel.font = UIFont(name: "AvenirNext-Medium", size: 16.0)
        emptyLabel.numberOfLines = 0
        emptyLabel.text = text
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor.white
        backgroundView.addSubview(emptyLabel)
        
        return backgroundView
    }
    
    class func navigationTitle(text: String) -> UILabel {
        let label = UILabel()
        
        label.textColor = UIColor(displayP3Red: 189.0/255.0, green: 57.0/255.0, blue: 65.0/255.0, alpha: 1)
        label.font = UIFont(name: "AvenirNext-Medium", size: 18)
        label.text = text
        
        label.sizeToFit()
        
        return label
    }
}
