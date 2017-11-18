//
//  ReciperDetailViewController.swift
//  Food2Fork
//
//  Created by Michael Redoble on 18/11/2017.
//  Copyright © 2017 mjredoble. All rights reserved.
//

import UIKit

class RecipeDetailViewController: UIViewController {
    
    var recipe: Recipe?
    
    @IBOutlet weak var recipeImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    func navigationTitle(text: String) -> UILabel {
        let label = UILabel()
        
        label.textColor = UIColor(displayP3Red: 189.0/255.0, green: 57.0/255.0, blue: 65.0/255.0, alpha: 1)
        label.font = UIFont(name: "AvenirNext-Medium", size: 18)
        label.text = text
        
        label.sizeToFit()
        
        return label
    }
    
    func configureView() {
        self.navigationItem.titleView = navigationTitle(text: recipe!.title)
        
        recipeImageView.image = nil
        if let imageURL = recipe?.imageUrl {
            recipeImageView.loadImageUsingCache(withUrl: imageURL)
        }
    }
}
