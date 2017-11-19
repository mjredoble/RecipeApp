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
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitles.count
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
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitles[section].uppercased()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ingredientCell")!
        if indexPath.section == 0 {
            let text = recipe?.ingredients[indexPath.row]
            cell.textLabel?.text = text
        }

        return cell
    }
}
