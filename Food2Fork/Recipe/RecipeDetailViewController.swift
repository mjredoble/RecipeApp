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
    
    func configureView() {
        self.navigationItem.titleView = UIHelper.navigationTitle(text: recipe!.title)
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 50.0
        tableView.tableFooterView = UIView()
        
        rankLabel.text = "Rank: \(recipe!.socialRank ?? 0)"
        publisherLabel.text = recipe?.publisher
        
        recipeImageView.image = nil
        if let imageURL = recipe?.imageUrl {
            recipeImageView.loadImageUsingCache(withUrl: imageURL)
        }
    }
    
    func configureTableViews() {
        if recipe?.ingredients.count == 0 {
            tableView.backgroundView = UIHelper.emptyView(frame: tableView.frame, withText: "No data available")
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
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return (recipe?.ingredients.count)!
        }
        else {
            return 2
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if recipe!.ingredients.count > 0 {
            let view = UIView(frame: CGRect(x: -2, y: 0, width: self.view.frame.size.width + 4, height: 28))
            view.backgroundColor = UIColor(displayP3Red: 245.0/255.0, green: 245.0/255.0, blue: 245.0/255.0, alpha: 1)
            
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
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ingredientCell", for: indexPath) as! IngredientTableViewCell
            cell.ingredient = (recipe?.ingredients[indexPath.row])!
            cell.selectionStyle = UITableViewCellSelectionStyle.none
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "infoCell", for: indexPath) as! InfoTableViewCell
            cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: .greatestFiniteMagnitude)
            
            if indexPath.row == 0 {
                cell.cellText = "View Instruction"
            }
            else {
                cell.cellText = "View Original"
            }
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        var urlToOpen = ""
        
        if indexPath.section == 1 {
            if indexPath.row == 0 {
                urlToOpen = recipe!.f2fUrl
            }
            else {
                urlToOpen = recipe!.publisherUrl
            }
            
            self.performSegue(withIdentifier: "WebViewSegue", sender: urlToOpen)
        }
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "WebViewSegue" {
            let destinationViewController = segue.destination as! DetailWebViewController
            destinationViewController.urlToOpen = sender as? String
        }
    }
}
