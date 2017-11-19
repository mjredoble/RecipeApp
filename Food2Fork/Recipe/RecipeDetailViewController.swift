//
//  ReciperDetailViewController.swift
//  Food2Fork
//
//  Created by Michael Redoble on 18/11/2017.
//  Copyright © 2017 mjredoble. All rights reserved.
//

import UIKit

class RecipeDetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var recipe: Recipe?
    var sectionTitles = ["Ingredients", "Info"]
    
    @IBOutlet weak var recipeImageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var rankLabel: UILabel!
    @IBOutlet weak var publisherLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadData()
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
        
        rankLabel.text = "Rank: \(recipe!.socialRank)"
        publisherLabel.text = recipe?.publisher
        recipeImageView.image = nil
        if let imageURL = recipe?.imageUrl {
            recipeImageView.loadImageUsingCache(withUrl: imageURL)
        }
    }
    
    func loadData() {
        RecipeDataSource.getIngredients(
            recipeId:recipe!.recipeId!,
            successHandler: { result in
                DispatchQueue.main.async {
                    self.recipe?.ingredients.append(contentsOf: result)
                    self.tableView.reloadData()
                }
        }, errorHandler: {
            NSLog("Error getIngredients API call......")
        })
    }
    
    //MARK: - UITableView Delegate Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if recipe!.ingredients.count > 0 {
            return (recipe?.ingredients.count)!
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ingredientCell")!
        let text = recipe?.ingredients[indexPath.row]
        
        cell.textLabel?.text = text
        
        return cell
    }
}
