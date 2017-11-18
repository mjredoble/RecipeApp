//
//  RecipeTableViewCell.swift
//  Food2Fork
//
//  Created by Michael Redoble on 18/11/2017.
//  Copyright © 2017 mjredoble. All rights reserved.
//

import UIKit

class RecipeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var recipeLabel: UILabel!
    
    var recipe: Recipe? {
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
        recipeImage.layer.cornerRadius = 20.0
        recipeImage.clipsToBounds = true
        
        recipeLabel.text = recipe?.title
        
        recipeImage.image = nil
        if let imageURL = recipe?.imageUrl {
            recipeImage.loadImageUsingCache(withUrl: imageURL)
        }
    }
}
