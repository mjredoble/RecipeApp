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
    
    func emptyView(frame: CGRect, withText text: String) -> UIView {
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
    
    func configureView() {
        self.navigationItem.titleView = navigationTitle(text: recipe!.title)
        
        tableView.tableFooterView = UIView()
        rankLabel.text = "Rank: \(recipe!.socialRank)"
        publisherLabel.text = recipe?.publisher
        
        recipeImageView.image = nil
        if let imageURL = recipe?.imageUrl {
            recipeImageView.loadImageUsingCache(withUrl: imageURL)
        }
    }
    
    func configureTableViews() {
        if recipe?.ingredients.count == 0 {
            tableView.backgroundView = emptyView(frame: tableView.frame, withText: "No data available")
        }
        else {
            tableView.backgroundView = nil
        }
    }
    
    func loadData() {
        RecipeDataSource.getIngredients(
            recipeId:recipe!.recipeId!,
            successHandler: { result in
                DispatchQueue.main.async {
                    self.recipe?.ingredients.append(contentsOf: result)
                    self.configureTableViews()
                    self.tableView.reloadData()
                }
        }, errorHandler: {
            DispatchQueue.main.async {
                self.configureTableViews()
                self.tableView.reloadData()
            }
            
            NSLog("Error getIngredients API call......")
        })
    }
    
    //MARK: - UITableView Delegate Methods
    func numberOfSections(in tableView: UITableView) -> Int {
        if recipe!.ingredients.count > 0 {
            return sectionTitles.count
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
            return 28
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return (recipe?.ingredients.count)!
        }
        else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if recipe!.ingredients.count > 0 {
            let view = UIView(frame: CGRect(x: -2, y: 0, width: self.view.frame.size.width + 4, height: 28))
            view.backgroundColor = UIColor.lightGray
            
            let label = UILabel(frame: CGRect(x: 16, y: 0, width: self.view.frame.size.width - 32, height: 28))
            label.textColor = UIColor.black
            
            label.font = UIFont(name: "AvenirNext-Bold", size: 12)
            label.textAlignment = .left
            label.text = self.tableView(tableView, titleForHeaderInSection: section)
            label.textColor = UIColor.black
            
            view.addSubview(label)
            
            return view
        }
 
        return nil
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitles[section].uppercased()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ingredientCell", for: indexPath) as! IngredientTableViewCell
        if indexPath.section == 0 {
            cell.ingredient = (recipe?.ingredients[indexPath.row])!
        }

        return cell
    }
}
