//
//  IngredientTableViewCell.swift
//  Food2Fork
//
//  Created by Michael Redoble on 19/11/2017.
//  Copyright © 2017 mjredoble. All rights reserved.
//

import UIKit

class IngredientTableViewCell: UITableViewCell {

    var ingredient: String? {
        didSet {
            configureView()
        }
    }
    
    @IBOutlet weak var ingredientLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configureView() {
        ingredientLabel.text = ingredient
    }
}
